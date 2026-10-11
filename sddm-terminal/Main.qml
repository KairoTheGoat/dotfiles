import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "black"

    readonly property color accent: "#ff3c3c"
    readonly property color fg: "#ebebeb"
    readonly property string mono: "JetBrainsMono Nerd Font"

    Image {
        anchors.fill: parent
        source: "bg.png"
        fillMode: Image.PreserveAspectCrop
        smooth: true
    }
    Rectangle { anchors.fill: parent; color: "black"; opacity: 0.55 }

    Text {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2 - 300
        font.family: root.mono
        font.pixelSize: 150
        font.bold: true
        color: root.fg
        text: Qt.formatTime(new Date(), "HH:mm")
    }

    Text {
        id: dateText
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2 - 130
        font.family: root.mono
        font.pixelSize: 24
        font.bold: true
        color: root.accent
        text: Qt.formatDate(new Date(), "dddd // dd.MM.yyyy")
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2 - 60
        font.family: root.mono
        font.pixelSize: 18
        color: "#99ebebeb"
        text: "[ " + (userModel.lastUser ? userModel.lastUser : "user") + "@arch ]"
    }

    TextField {
        id: pw
        width: 320
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2
        echoMode: TextInput.Password
        passwordCharacter: "•"
        placeholderText: "enter password"
        placeholderTextColor: "#88ffffff"
        color: root.fg
        font.family: root.mono
        font.pixelSize: 18
        horizontalAlignment: TextInput.AlignHCenter
        focus: true
        background: Rectangle {
            color: "#80000000"
            border.color: root.accent
            border.width: 2
        }
        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                sddm.login(userModel.lastUser, pw.text, sessionModel.lastIndex)
                event.accepted = true
            }
        }
    }

    Text {
        id: status
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2 + 70
        font.family: root.mono
        font.pixelSize: 16
        font.italic: true
        color: "#ff5555"
        text: ""
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            pw.text = ""
            status.text = "access denied"
            pw.forceActiveFocus()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clock.text = Qt.formatTime(new Date(), "HH:mm")
            dateText.text = Qt.formatDate(new Date(), "dddd // dd.MM.yyyy")
        }
    }
}
