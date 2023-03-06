import nigui
import strutils
import std/math

var inputIsNumber: bool
#var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

app.init()

var mainWindow = newWindow("Basic Calculator")
mainwindow.height = 235.scaleToDpi
mainwindow.width = 300.scaleToDpi

var rootContainer = newLayoutContainer(Layout_Vertical)
mainWindow.add(rootContainer)

rootContainer.add(newLabel("First number:"))

var firstNumEntry = newTextBox()
rootContainer.add(firstNumEntry)

rootContainer.add(newLabel("Second number:"))

var secondNumEntry = newTextBox()
rootContainer.add(secondNumEntry)

var operationSelect = newComboBox(@["Add", "Subtract", "Multiply", "Divide"])
var decimalPlaceEntry = newTextBox()
var answerDecimalPlace = 4
decimalPlaceEntry.text = $answerDecimalPlace

var operationContainer = newLayoutContainer(Layout_Horizontal)
rootContainer.add(operationContainer)
operationContainer.add(newLabel("Operation:"))
operationContainer.add(operationSelect)
operationContainer.add(newLabel("Decimal Place: "))
operationContainer.add(decimalPlaceEntry)

var calculateButton = newButton("Calculate")
rootContainer.add(calculateButton)

var answerLabel = newLabel("Answer: ")
var reuseAnswerButton = newButton("Reuse Answer")

var answerContainer = newLayoutContainer(Layout_Horizontal)
rootContainer.add(answerContainer)
answerContainer.add(answerLabel)
answerContainer.add(reuseAnswerButton)

# Procedure created by ChatGPT

proc isNumeric(s: string): bool {.discardable.} =
    for c in s:
        if not c.isDigit:
            return false
    return s.len > 0

calculateButton.onClick = proc(event: ClickEvent) =
    inputIsNumber = true
    if (decimalPlaceEntry.text != ""):
        answerDecimalPlace = decimalPlaceEntry.text.parseInt()
    if (isNumeric(firstNumEntry.text) and isNumeric(secondNumEntry.text)):
        case operationSelect.value:
            of "Add":
                answerLabel.text = "Answer: " & $round(firstNumEntry.text.parseFloat() + secondNumEntry.text.parseFloat(), answerDecimalPlace)
            of "Subtract":
                answerLabel.text = "Answer: " & $round(firstNumEntry.text.parseFloat() - secondNumEntry.text.parseFloat(), answerDecimalPlace)
            of "Multiply":
                answerLabel.text = "Answer: " & $round(firstNumEntry.text.parseFloat() * secondNumEntry.text.parseFloat(), answerDecimalPlace)
            of "Divide":
                answerLabel.text = "Answer: " & $round(firstNumEntry.text.parseFloat() / secondNumEntry.text.parseFloat(), answerDecimalPlace)
    else:
        mainWindow.alert("Enter numbers to calculate")

# Set first input entry to be the answer

reuseAnswerButton.onClick = proc(event: ClickEvent) =
    # split() requires a string to split at, and outputs an array of strings outside that string entered.
    # [] is used to get a certain index. array[index]
    firstNumEntry.text = (answerLabel.text.split(" "))[1]

# Show window and run app

mainWindow.show()
firstNumEntry.focus()
app.run()