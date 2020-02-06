class ctrlButton;
class ctrlListNBox;
class ctrlProgress;
class ctrlButtonPicture;
class ctrlToolboxPictureKeepAspect;

class EGVAR(common,RscLabel);
class EGVAR(common,RscBackground);
class EGVAR(common,RscEdit);

class EGVAR(common,RscDisplay) {
    class controls {
        class Title;
        class Background;
        class Content;
        class ButtonOK;
        class ButtonCancel;
    };
};

class GVAR(display): EGVAR(common,RscDisplay) {
    class controls: controls {
        class Title: Title {};
        class Background: Background {};
        class Content: Content {
            h = POS_H(13/3 + 14.3);
            class controls {
                class Category: ctrlToolboxPictureKeepAspect {
                    idc = IDC_CATEGORY;
                    x = 0;
                    y = 0;
                    w = POS_W(26);
                    h = POS_H(13/3);
                    rows = 2;
                    columns = 12;
                    strings[] = {
                        "\a3\Ui_F_Curator\Data\RscCommon\RscAttributeInventory\filter_0_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\PrimaryWeapon_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\SecondaryWeapon_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Handgun_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemOptic_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemAcc_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemMuzzle_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\ItemBipod_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoMagAll_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Headgear_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Uniform_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Vest_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Backpack_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Goggles_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\NVGs_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Binoculars_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Map_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Compass_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Radio_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\Watch_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\GPS_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoThrow_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoPut_ca.paa",
                        "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\CargoMisc_ca.paa"
                    };
                };
                class ListBackground: EGVAR(common,RscBackground) {
                    x = 0;
                    y = POS_H(13/3);
                    w = POS_W(26);
                    h = POS_H(13);
                };
                class List: ctrlListNBox {
                    idc = IDC_LIST;
                    idcLeft = IDC_BTN_REMOVE;
                    idcRight = IDC_BTN_ADD;
                    x = 0;
                    y = POS_H(13/3);
                    w = POS_W(26);
                    h = POS_H(13);
                    drawSideArrows = 1;
                    disableOverflow = 1;
                    columns[] = {0.05, 0.15, 0.85};
                };
                class ButtonRemove: ctrlButton {
                    idc = IDC_BTN_REMOVE;
                    text = "−";
                    font = "RobotoCondensedBold";
                    x = -1;
                    y = -1;
                    w = POS_W(1);
                    h = POS_H(1);
                    sizeEx = POS_H(1.2);
                };
                class ButtonAdd: ButtonRemove {
                    idc = IDC_BTN_ADD;
                    text = "+";
                };
                class ButtonSearch: ctrlButtonPicture {
                    idc = IDC_BTN_SEARCH;
                    text = "\a3\Ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
                    x = 0;
                    y = POS_H(13/3 + 13.3);
                    w = POS_W(1);
                    h = POS_H(1);
                    colorBackground[] = {0, 0, 0, 0.5};
                    offsetPressedX = 0;
                    offsetPressedY = 0;
                };
                class SearchBar: EGVAR(common,RscEdit) {
                    idc = IDC_SEARCH_BAR;
                    x = POS_W(1.2);
                    y = POS_H(13/3 + 13.3);
                    w = POS_W(8);
                    h = POS_H(1);
                    sizeEx = POS_H(0.9);
                };
                class Load: ctrlProgress {
                    idc = IDC_LOAD;
                    x = POS_W(15);
                    y = POS_H(13/3 + 13.3);
                    w = POS_W(9.9);
                    h = POS_H(1);
                    colorFrame[] = {1, 1, 1, 1};
                };
                class ButtonClear: ButtonSearch {
                    idc = IDC_BTN_CLEAR;
                    text = "\a3\3den\data\cfg3den\history\deleteitems_ca.paa";
                    tooltip = "$STR_disp_arcmap_clear";
                    x = POS_W(25);
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
