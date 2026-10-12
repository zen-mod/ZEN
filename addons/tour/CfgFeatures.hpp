/*
 * Features are the content of the tour catalog, presented as a page each.
 *
 * Feature properties:
 *   title        - The feature's name.
 *   description  - The lead text (i.e., an introduction), shown below the title.
 *
 *   The header can contain media, as described below.
 *
 * Each subclass is a section of the page, shown in order:
 *   title        - An optional heading for the section.
 *   text         - Structured text, where {key} tokens become keycaps or mouse icons
 *                  (e.g., {ctrl}, {f1}, {lmb}, {dblclick}),
 *                  <b> makes text bold, and <br/> starts a new line.
 *   items[]      - An optional list to show below the text, where an item can be {term, description}
 *                  for a two column row. Sections can be listings only as well.
 *   numbered     - Number the list instead of using bullets (default: 0).
 *   style        - An optional "note", "tip", or "warning" to show the section as a callout.
 *   layout       - Placement of the section's media: "top" (default), "left", or "right" of the text.
 *
 *   A section can contain media, as described below.
 *
 * Features and sections can show one of the following media, kept at the aspect ratio of its (first) picture:
 *   picture      - A JPEG or PAA picture.
 *   comparison[] - Before and after pictures of the same size, split by a divider that can be dragged.
 *   slides[]     - Pictures of the same size shown one at a time, each as {picture, caption (optional)}.
 *
 * Pictures can draw attention to an area, animating each time they are scrolled into view:
 *   focus[]      - Area of the picture to focus as {x, y, w, h} fractions.
 *   zoom         - Zoom factor, centered on the focus area or the picture's center without one
 *                  (default: enough for the focus area to fill most of the picture, 1 to not zoom).
 *   highlight    - Dim the rest of the picture around the focus area (default: 1).
 *   loop         - Keep zooming in and out while visible (default: 0).
 */
class GVAR(features) {
    class Comments {
        title = "$STR_3DEN_Comment_textPlural";
        description = CSTRING(Comments_Description);
        picture = QPATHTOF(features\comments\header.jpg);
        focus[] = {0.36, 0.37, 0.24, 0.34};
        class Placing {
            title = CSTRING(Comments_Placing);
            text = CSTRING(Comments_Placing_Text);
            picture = QPATHTOF(features\comments\placing.jpg);
            zoom = 1.15;
            layout = "right";
        };
        class Editing {
            title = CSTRING(Comments_Editing);
            text = CSTRING(Comments_Editing_Text);
            items[] = {
                {"{drag}", CSTRING(Comments_Move)},
                {"{dblclick}", CSTRING(Comments_Edit)},
                {"{delete}", CSTRING(Comments_Delete)}
            };
        };
        class Shared {
            text = CSTRING(Comments_Shared_Text);
            style = "note";
        };
        class Eden {
            title = CSTRING(Comments_Eden);
            text = CSTRING(Comments_Eden_Text);
        };
    };
    class SelectionPresets {
        title = ECSTRING(selection_presets,DisplayName);
        description = CSTRING(SelectionPresets_Description);
        picture = QPATHTOF(features\selection_presets\header.jpg);
        focus[] = {0.28, 0.962, 0.44, 0.038};
        class Saving {
            title = CSTRING(SelectionPresets_Saving);
            text = CSTRING(SelectionPresets_Saving_Text);
            items[] = {
                {"{ctrl} + {1} ... {0}", CSTRING(SelectionPresets_SaveToSlot)},
                {"{ctrl} + {lmb}", CSTRING(SelectionPresets_Replace)},
                {"{ctrl} + {shift} + {lmb}", CSTRING(SelectionPresets_Add)}
            };
        };
        class Selecting {
            title = CSTRING(SelectionPresets_Selecting);
            text = CSTRING(SelectionPresets_Selecting_Text);
            items[] = {
                {"{lmb}", CSTRING(SelectionPresets_SelectClick)},
                {"{1} ... {0}", CSTRING(SelectionPresets_SelectKey)}
            };
        };
        class Contents {
            text = CSTRING(SelectionPresets_Contents_Text);
            style = "tip";
        };
        class Customizing {
            title = CSTRING(SelectionPresets_Customizing);
            text = CSTRING(SelectionPresets_Customizing_Text);
            items[] = {
                CSTRING(SelectionPresets_EmptySlots),
                CSTRING(SelectionPresets_GroupIcons),
                CSTRING(SelectionPresets_Tooltips),
                CSTRING(SelectionPresets_Exclude),
                CSTRING(SelectionPresets_Disable)
            };
        };
        class Persistence {
            text = CSTRING(SelectionPresets_Persistence_Text);
            style = "note";
        };
    };
};
