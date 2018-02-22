import QtQuick 2.6
import "qrc:/JS/helper.js" as Helper

import "../Shaders" as Shaders

PitchScale {
    id: root

    property bool inputEnabled: false
    property real inputValue: 0
    property real inputMin: -1
    property real inputMax: 1
    property color inputColor: palette.cautionColor

    signal picked(real value)

    onInputValueChanged: canvas.requestPaint()
    onWidthChanged: canvas.requestPaint()
    onHeightChanged: canvas.requestPaint()

    Canvas {
        id: canvas
        anchors.fill: parent
        visible: inputEnabled
        onPaint: {
            var ctx = canvas.getContext('2d');

            ctx.clearRect(0, 0, width, height);
            ctx.strokeStyle = inputColor;
            ctx.lineWidth = 2;

            ctx.save();
            ctx.translate(width / 2, Helper.mapToRange(inputValue, inputMin, inputMax,
                                                       height - width / 16 - 2));

            ctx.beginPath();
            ctx.moveTo(-width / 16, width / 16);
            ctx.lineTo(0, 0);
            ctx.lineTo(width / 16, width / 16);
            ctx.stroke();

            ctx.restore();
        }
    }

    MouseArea {
        anchors.fill: root
        onMouseYChanged: root.picked(-Helper.mapFromRange(
                                         Math.max(0, Math.min(root.height, root.height - mouseY)),
                                         inputMin, inputMax, root.height))
    }
}
