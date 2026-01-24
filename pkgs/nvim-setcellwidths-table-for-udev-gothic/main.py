import argparse
from collections.abc import Generator
from fontTools.ttLib import TTFont
from pathlib import Path
import unicodedata

def ambiguous_codepoints() -> Generator[int]:
    for cp in range(0x00000, 0x30000):
        try:
            char = chr(cp)
            eaw = unicodedata.east_asian_width(char)
            if eaw == 'A':
                yield cp
        except (ValueError, UnicodeEncodeError):
            continue

def get_glyph_width(font: TTFont, codepoint: int) -> int | None:
    cmap = font.getBestCmap()
    if cmap is None:
        return None

    glyph_name = cmap.get(codepoint)
    if glyph_name is None:
        return None

    if 'hmtx' not in font:
        return None

    hmtx = font['hmtx']
    if glyph_name not in hmtx.metrics:
        return None

    width, _ = hmtx.metrics[glyph_name]
    return width

def get_reference_widths(font: TTFont) -> tuple[int | None, int | None]:
    halfwidth_ref = None
    for cp in [0x0041, 0x0030, 0x0061]:
        w = get_glyph_width(font, cp)
        if w is not None and w > 0:
            halfwidth_ref = w
            break

    fullwidth_ref = None
    for cp in [0xFF21, 0x3042, 0x6F22, 0x4E00]:
        w = get_glyph_width(font, cp)
        if w is not None and w > 0:
            fullwidth_ref = w
            break

    return halfwidth_ref, fullwidth_ref

def classify_width(width: int, half_ref: int, full_ref: int) -> str:
    if width <= (half_ref + full_ref) / 2:
        return "half"
    else:
        return "full"

def analyze_font(font_path: str) -> dict:
    font = TTFont(font_path)

    stats = {
        "half": [],
        "full": [],
    }

    half_ref, full_ref = get_reference_widths(font)
    if half_ref is None or full_ref is None:
        return stats

    for cp in ambiguous_codepoints():
        width = get_glyph_width(font, cp)
        if width is None:
            continue

        classification = classify_width(width, half_ref, full_ref)
        stats[classification].append(cp)

    font.close()
    return stats

def merge_ranges(codepoints: list[int]) -> list[tuple[int, int]]:
    if not codepoints:
        return []
    sorted_cps = sorted(codepoints)
    ranges = []
    start = sorted_cps[0]
    end = sorted_cps[0]
    for cp in sorted_cps[1:]:
        if cp == end + 1:
            end = cp
        else:
            ranges.append((start, end))
            start = cp
            end = cp
    ranges.append((start, end))
    return ranges

def generate_table(stats: dict) -> str:
    prefix = [
        "local M = {}",
        "",
        "function M.setcellwidths()",
        "   vim.fn.setcellwidths({",
    ]
    table = []
    for start, end in merge_ranges(stats["full"]):
        chars = ", ".join("%s (U+%04X)" % (chr(cp), cp) for cp in range(start, end + 1))
        table.append("      -- %s" % chars)
        table.append("      {%#06x, %#06x, 2}," % (start, end))
    suffix = [
        "   })",
        "end",
        "",
        "return M",
    ]
    return "\n".join(prefix + table + suffix)

def main():
    parser = argparse.ArgumentParser(
        description='Generate Neovim setcellwidths() table'
    )
    parser.add_argument('font', help='Font file path')

    args = parser.parse_args()

    if not Path(args.font).exists():
        print(f"Font file not found: {args.font}")
        return 1

    stats = analyze_font(args.font)
    table = generate_table(stats)
    print(table)
    return 0

if __name__ == '__main__':
    exit(main())
