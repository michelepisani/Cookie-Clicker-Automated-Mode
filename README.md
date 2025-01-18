# Cookie-Clicker-Automated-Mode
Scripts for simulated and automatic click biscuits, to play smart without forcing or hacking the game

## Click on the Big cookie and the Golden cookie
Using the browser console it is possible to insert two JavaScript functions that respectively simulate a perpetual click every specific interval on the main Biscuit and detect the appearance of the golden biscuit in order to click it automatically showing the bonus received in the console.

## How It Works
The *startAutoClicker* function, based on the interval value in milliseconds passed (maximum 400ms due to browser limits), continuously clicks the element with the *bigCookie* id. Starting the *stopAutoClicker()* function terminates execution.
The function *observeShimmers()* detects the addition to the document of elements associated with the golden button (*shimmer*) and simulates a click on it to obtain the bonus; at the same time the detail of the bonus received will be written to the console,  obtained from the element *particle0*.

## Issues
No issue detected.

## Challenge
Automatically manage new clickable items, including *wrath* cookies and *Wrinklers*, that appear after activating the *One Mind* update.

## How to test
Open https://orteil.dashnet.org/cookieclicker/, paste the code into the console, click the enter key.
