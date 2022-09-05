import QtQuick 2.2
import QtQuick.Controls 2.5
import Process 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Run a sh file in CMD!"

    property var str:"unu"
    //property var pathm: "${USER}"+CurDirPath+"/scripts/install_akt_ota-cli.sh"

    Process {
        id: cmd

        property string output: ""


        onStarted: print("Started")
        onFinished: print("Closed")

        onErrorOccurred: console.log("Error Ocuured: ", error)

        onReadyReadStandardOutput: {
            output = cmd.readAll()
            txt.text += output
        }
    }

    Rectangle {
        anchors.fill : parent
        ScrollView {
                    id: scrollView
                    width: 500
                    clip: true
                    anchors{
                        left: parent.left
                        top:parent.top
                        bottom: parent.bottom
                    }

                    TextArea {
                        id: txt


                        readOnly:           true
                        textFormat:         TextEdit.RichText
                        text:              "here"
                        width: parent.width
                        height: parent.height
                        anchors.fill: parent
                        function append()
                        {
                            //txt.text = txt.text + strAdd
                            txt.cursorPosition = txt.length-10
                        }
                    }
                }

               Timer {
                    running: true
                    interval: 50
                    repeat: true
                    property int iteration: 0

                    onTriggered:{
                        if(str=="doi"){
                        txt.append()
                        txt.append()
                        }
                     }
                }

        Button {

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: "Run!"
            onClicked: {
                str="doi"
                cmd.start("/home/dragos/Desktop/GitHub/ota-gui/install_akt_ota-cli.sh",["-a"])
            }
        }
    }
}
