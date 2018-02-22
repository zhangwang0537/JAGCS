﻿import QtQuick 2.6

import "../Controls" as Controls

AttitudeIndicator {
    id: fd

    property bool armed: false
    property bool guided: false
    property bool operational: false

    property real yawspeed: 0.0
    property real desiredPitch: 0.0
    property real desiredRoll: 0.0

    property real pitchStep: 5
    property real maxRoll: width > height ? 90 : 90 - (180 * Math.acos(width / height) / Math.PI)
    property real minRoll: -maxRoll
    property real rollStep: 10

    property bool inputEnabled: false
    property alias inputPitch: pitchScale.inputValue
    property alias inputRoll: rollScale.inputValue

    signal pitchPicked(real value)
    signal rollPicked(real value)

    Behavior on yawspeed { PropertyAnimation { duration: 100 } }
    Behavior on desiredPitch { PropertyAnimation { duration: 100 } }
    Behavior on desiredRoll { PropertyAnimation { duration: 100 } }

    effectiveHeight: height - sizings.controlBaseSize * 2

    RollScalePicker {
        id: rollScale
        anchors.fill: parent
        roll: rollInverted ? -fd.roll : fd.roll
        minRoll: fd.minRoll
        maxRoll: fd.maxRoll
        rollStep: fd.rollStep
        opacity: enabled ? 1 : 0.33
        color: operational ? palette.textColor : palette.dangerColor
        inputEnabled: fd.inputEnabled
        onPicked: fd.rollPicked(value)
    }

    PitchScalePicker {
        id: pitchScale
        anchors.centerIn: parent
        width: parent.width
        height: effectiveHeight
        roll: rollInverted ? 0 : fd.roll
        minPitch: pitchInverted ? fd.pitch + fd.minPitch : fd.minPitch
        maxPitch: pitchInverted ? fd.pitch + fd.maxPitch : fd.maxPitch
        pitchStep: fd.pitchStep
        opacity: enabled ? 1 : 0.33
        color: operational ? palette.textColor : palette.dangerColor
        inputEnabled: fd.inputEnabled
        onPicked: fd.pitchPicked(value)
    }

    TurnIndicator {
        id: turn
        anchors.fill: parent
        value: yawspeed
    }

    Controls.Label {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -height
        text: qsTr("DISARMED")
        font.pixelSize: fd.height * 0.1
        font.bold: true
        color: armed ? "transparent" : palette.dangerColor
    }

    DesiredAnglesMark {
        id: desiredMark
        anchors.fill: parent
        anchors.margins: sizings.margins
        effectiveHeight: fd.effectiveHeight
        visible: guided
        pitch: pitchInverted ? fd.pitch - desiredPitch : -desiredPitch
        roll: rollInverted ? -desiredRoll : fd.roll - desiredRoll
    }

    PlaneMark {
        id: mark
        anchors.fill: parent
        anchors.margins: sizings.margins
        effectiveHeight: fd.effectiveHeight
        pitch: pitchInverted ? 0 : -fd.pitch
        roll: rollInverted ? -fd.roll : 0
        markColor: armed ? palette.selectedTextColor : palette.dangerColor
        markWidth: 3
    }
}
