#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = ["pillow"]
# ///
"""Generates the keycap and icon textures used by the tour component.

Keycaps and mouse icons are referenced in page text as {name} tokens (e.g., {ctrl}, {f1}, {lmb}).
They are drawn entirely in white so that structured text can tint them.
Shapes are drawn at 8x scale and downsampled for clean anti-aliasing, then
converted to PAA using HEMTT.

Labels use the Barlow Condensed font (SIL Open Font License), which is downloaded
automatically. Only the rendered textures are included in the mod, not the font.
"""

import os
import string
import subprocess
import sys
import tempfile
import urllib.request

from PIL import Image, ImageDraw, ImageFont

FONT_URL = "https://github.com/google/fonts/raw/main/ofl/barlowcondensed/BarlowCondensed-SemiBold.ttf"

SCALE = 8
HEIGHT = 64

COLOR_WHITE = (255, 255, 255, 255)
COLOR_HANDLE = (32, 32, 32, 255)

# Space around a keycap's edge, which mouse icons also keep
KEY_MARGIN = 2

MOUSE_WIDTH = 22
MOUSE_HEIGHT = 38
MOUSE_SCALE = 1.25

# Space between a mouse and its symbol, and the symbol's size relative to the mouse
SYMBOL_GAP = 5
SYMBOL_SIZE = 0.85

ROOT = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "..", "addons", "tour", "ui"
)

LABELS = {
    "ctrl": "CTRL",
    "shift": "SHIFT",
    "alt": "ALT",
    "tab": "TAB",
    "esc": "ESC",
    "enter": "ENTER",
    "space": "SPACE",
    "backspace": "BACKSPACE",
    "delete": "DEL",
    "insert": "INS",
    "home": "HOME",
    "end": "END",
    "pageup": "PG UP",
    "pagedown": "PG DN",
    "capslock": "CAPS",
}
LABELS.update({c: c.upper() for c in string.ascii_lowercase})
LABELS.update({c: c for c in string.digits})
LABELS.update({f"f{i}": f"F{i}" for i in range(1, 13)})

ARROWS = {"up": 0, "right": 90, "down": 180, "left": 270}

MOUSE = ["lmb", "rmb", "mmb", "wheel", "dblclick", "drag"]


def s(value):
    """Returns the given size scaled up for drawing."""

    return round(value * SCALE)


def get_font():
    """Returns the path to the label font, downloading it on first use."""

    path = os.path.join(tempfile.gettempdir(), "zen_tour", os.path.basename(FONT_URL))

    if not os.path.exists(path):
        os.makedirs(os.path.dirname(path), exist_ok=True)
        urllib.request.urlretrieve(FONT_URL, path)

    return path


def keycap(width):
    """Returns a blank keycap and the bounds of its top face."""

    image = Image.new("RGBA", (s(width), s(HEIGHT)), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    # The thicker bottom edge gives the key some depth, while the face is cut out to keep the texture entirely white
    draw.rounded_rectangle(
        [s(KEY_MARGIN), s(3), s(width - KEY_MARGIN), s(HEIGHT - 3)],
        s(8),
        fill=COLOR_WHITE,
    )
    face = [s(4), s(5), s(width - 4), s(HEIGHT - 8)]
    draw.rounded_rectangle(face, s(6), fill=(0, 0, 0, 0))

    return image, draw, face


def draw_text(draw, text, font, cx, cy):
    """Draws the given text centered on a point."""

    # Center the glyphs themselves, since font metrics include space for descenders
    left, top, right, bottom = font.getbbox(text, anchor="ls")
    x = cx - (right - left) / 2 - left
    y = cy - (bottom - top) / 2 - top
    draw.text((x, y), text, font=font, fill=COLOR_WHITE, anchor="ls")


def label_key(text, font_path):
    """Returns a keycap labeled with the given text, as wide as the label needs."""

    font = ImageFont.truetype(font_path, s(42 if len(text) == 1 else 34))
    text_width = font.getlength(text) / SCALE

    # Keep power of two dimensions for PAA
    width = next(w for w in (64, 128, 256) if text_width + 20 <= w)

    image, draw, face = keycap(width)
    draw_text(draw, text, font, (face[0] + face[2]) / 2, (face[1] + face[3]) / 2)
    return image


def draw_arrow(image, cx, cy, angle, size=1):
    """Draws an arrow centered on a point, pointing at the given angle clockwise from up."""

    glyph = Image.new("RGBA", image.size, (0, 0, 0, 0))
    draw = ImageDraw.Draw(glyph)

    head = [
        (cx, cy - s(12 * size)),
        (cx + s(10 * size), cy - s(size)),
        (cx - s(10 * size), cy - s(size)),
    ]
    draw.polygon(head, fill=COLOR_WHITE)
    draw.rectangle(
        [cx - s(3 * size), cy - s(2 * size), cx + s(3 * size), cy + s(12 * size)],
        fill=COLOR_WHITE,
    )

    glyph = glyph.rotate(-angle, center=(cx, cy), resample=Image.BICUBIC)
    image.alpha_composite(glyph)


def arrow_key(angle):
    """Returns a keycap with an arrow pointing at the given angle."""

    image, _draw, face = keycap(HEIGHT)
    draw_arrow(image, (face[0] + face[2]) / 2, (face[1] + face[3]) / 2, angle)
    return image


def draw_mouse(image, draw, cx, cy, button, scale=1):
    """Draws a mouse with the given button ("left", "right", "middle", or "wheel") filled in."""

    def m(value):
        return s(value * scale)

    body = [
        cx - m(MOUSE_WIDTH / 2),
        cy - m(MOUSE_HEIGHT / 2),
        cx + m(MOUSE_WIDTH / 2),
        cy + m(MOUSE_HEIGHT / 2),
    ]
    split = cy - m(4)
    width = m(2.5)
    draw.rounded_rectangle(body, m(MOUSE_WIDTH / 2), outline=COLOR_WHITE, width=width)
    draw.line([body[0], split, body[2], split], fill=COLOR_WHITE, width=width)
    draw.line([cx, body[1], cx, split], fill=COLOR_WHITE, width=width)

    if button in ("left", "right"):
        mask = Image.new("L", image.size, 0)
        mask_draw = ImageDraw.Draw(mask)
        mask_draw.rounded_rectangle(body, m(MOUSE_WIDTH / 2), fill=255)
        mask_draw.rectangle([body[0], split, body[2], body[3]], fill=0)

        if button == "left":
            mask_draw.rectangle([cx, body[1], body[2], split], fill=0)
        else:
            mask_draw.rectangle([body[0], body[1], cx, split], fill=0)

        image.paste(Image.new("RGBA", image.size, COLOR_WHITE), (0, 0), mask)
        return

    wheel = [cx - m(3), cy - m(14), cx + m(3), cy - m(6)]
    draw.rounded_rectangle(wheel, m(3), fill=COLOR_WHITE)


def draw_arrows(draw, cx, cy, angles, size, head):
    """Draws arrows pointing away from the center at the given angles, joined by lines."""

    for angle in angles:
        direction = {0: (0, -1), 90: (1, 0), 180: (0, 1), 270: (-1, 0)}[angle]
        tip = (cx + direction[0] * s(size), cy + direction[1] * s(size))
        base = (cx + direction[0] * s(size - head), cy + direction[1] * s(size - head))
        side = (direction[1] * s(head * 0.8), direction[0] * s(head * 0.8))

        draw.line([(cx, cy), base], fill=COLOR_WHITE, width=s(3))
        draw.polygon(
            [
                tip,
                (base[0] + side[0], base[1] + side[1]),
                (base[0] - side[0], base[1] - side[1]),
            ],
            fill=COLOR_WHITE,
        )


def symbol(name, font_path):
    """Returns the symbol paired with a mouse, cropped to its content."""

    image = Image.new("RGBA", (s(64), s(64)), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    if name == "wheel":
        draw_arrows(draw, s(32), s(32), (0, 180), 22, 9)
    elif name == "dblclick":
        draw_text(draw, "×2", ImageFont.truetype(font_path, s(44)), s(32), s(32))
    else:
        draw_arrows(draw, s(32), s(32), (0, 90, 180, 270), 18, 7)

    return image.crop(image.getbbox())


def mouse_icon(name, font_path):
    """Returns a mouse icon, paired with a symbol for wheels, clicks, and drags."""

    buttons = {
        "lmb": "left",
        "rmb": "right",
        "mmb": "middle",
        "wheel": "wheel",
        "dblclick": "left",
        "drag": "left",
    }

    is_paired = name in ("wheel", "dblclick", "drag")
    image = Image.new("RGBA", (s(64 if is_paired else 32), s(HEIGHT)), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    cy = s(HEIGHT / 2)

    mouse_w = MOUSE_WIDTH * MOUSE_SCALE
    mouse_h = MOUSE_HEIGHT * MOUSE_SCALE

    if not is_paired:
        draw_mouse(image, draw, image.width / 2, cy, buttons[name], MOUSE_SCALE)
        return image

    mouse_x = s(KEY_MARGIN + mouse_w / 2)
    draw_mouse(image, draw, mouse_x, cy, buttons[name], MOUSE_SCALE)

    # Symbols fill the remaining space, staying smaller than the mouse
    left = KEY_MARGIN + mouse_w + SYMBOL_GAP
    box_w = s(64 - KEY_MARGIN - left)
    box_h = s(mouse_h * SYMBOL_SIZE)

    glyph = symbol(name, font_path)
    scale = min(box_w / glyph.width, box_h / glyph.height)
    glyph = glyph.resize(
        (round(glyph.width * scale), round(glyph.height * scale)), Image.LANCZOS
    )
    image.alpha_composite(glyph, (s(left), round(cy - glyph.height / 2)))

    return image


def compare_icon():
    """Returns the handle for dragging the divider of a before and after comparison."""

    image = Image.new("RGBA", (s(64), s(64)), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)
    draw.ellipse([s(4), s(4), s(60), s(60)], fill=COLOR_WHITE)
    draw.ellipse([s(8), s(8), s(56), s(56)], fill=COLOR_HANDLE)

    for direction in (-1, 1):
        tip = s(32 + direction * 18)
        base = s(32 + direction * 6)
        draw.polygon([(tip, s(32)), (base, s(23)), (base, s(41))], fill=COLOR_WHITE)

    return image


def save(image, path):
    """Saves the given image as a PAA, downsampled from its drawing scale."""

    size = (image.width // SCALE, image.height // SCALE)
    image = image.resize(size, Image.LANCZOS)

    with tempfile.TemporaryDirectory() as temp:
        png = os.path.join(temp, "image.png")
        image.save(png)

        if os.path.exists(path):
            os.remove(path)

        subprocess.run(
            ["hemtt", "utils", "paa", "convert", png, path],
            check=True,
            capture_output=True,
        )


def main():
    """Generates all keycaps and icons."""

    font_path = get_font()
    keys_dir = os.path.join(ROOT, "keys")
    icons_dir = os.path.join(ROOT, "icons")
    os.makedirs(keys_dir, exist_ok=True)
    os.makedirs(icons_dir, exist_ok=True)

    for name, text in LABELS.items():
        save(label_key(text, font_path), os.path.join(keys_dir, f"{name}_ca.paa"))

    for name, angle in ARROWS.items():
        save(arrow_key(angle), os.path.join(keys_dir, f"{name}_ca.paa"))

    for name in MOUSE:
        save(mouse_icon(name, font_path), os.path.join(keys_dir, f"{name}_ca.paa"))

    save(compare_icon(), os.path.join(icons_dir, "compare_ca.paa"))

    print(
        f"Generated {len(LABELS) + len(ARROWS)} keycaps, {len(MOUSE)} mouse icons, and 1 icon"
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
