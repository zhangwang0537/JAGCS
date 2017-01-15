import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

import "qrc:/Controls"

Frame {
    id: root

    property alias uiSize: uiSlider.value
    property alias paletteStyle: paletteBar.currentIndex

    signal updateSettings()

    GridLayout {
        anchors.fill: parent
        anchors.margins: palette.controlBaseSize / 2
        rowSpacing: palette.controlBaseSize / 2
        columns: 3

        Label {
            text: qsTr("UI size")
            Layout.fillWidth: true
        }

        Slider {
            id: uiSlider
            from: 24
            to: 64
            Layout.fillWidth: true
            onPressedChanged: {
                if (pressed) return;
                root.updateSettings();
                main.updateUiSettings();
            }
        }

        Label {
            Layout.preferredWidth: 86
            horizontalAlignment: Text.AlignHCenter
            text: (uiSlider.from + uiSlider.position *
                   (uiSlider.to - uiSlider.from)).toFixed(0)  // TODO: current value
        }

        Label {
            text: qsTr("Palette")
            Layout.fillWidth: true
        }

        Item {
            Layout.fillWidth: true
            Layout.columnSpan: 2
            height: paletteBar.height

            TabBar {
                id: paletteBar
                anchors.centerIn: parent
                width: parent.width
                onCurrentIndexChanged: {
                    root.updateSettings();
                    main.updateUiSettings();
                }

                TabButton {
                    text: qsTr("Indoor")
                }
                TabButton {
                    text: qsTr("Outdoor")
                }
            }
        }

        Label {
            text: qsTr("Language")
            Layout.fillWidth: true
        }

        ComboBox {
            id: languageBox
            Layout.columnSpan: 2
            Layout.fillWidth: true
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
