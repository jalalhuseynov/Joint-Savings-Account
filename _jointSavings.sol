pragma solidity ^0.5.0;

//Defining a contact named JointSavings 
contract JointSavings {

    // defining variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint256 public lastWithdrawalAmount;
    uint public contractBalance;

    // Defining a function named "withdraw" that is accepting two arguments: amount and recipient
    function withdraw(uint amount,address payable recipient) public {

        //`require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.
        
        require(recipient == accountOne || recipient == accountTwo, "You don’t own this account!");

        //`require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation. If there are insufficient funds, the text `Insufficient funds!` is returned.
        
        require(amount <= contractBalance, "Insufficient funds!");

        // `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal, then set it to the current value of `recipient`.
        
        if (lastToWithdraw != recipient) {
        lastToWithdraw = recipient;
        }
        //Calling the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.

        recipient.transfer(amount);

        // Setting  `lastWithdrawAmount` equal to `amount`
        lastWithdrawalAmount = amount;

        //Calling the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
        contractBalance = address(this).balance;
    }

    // Defining a `public payable` function named `deposit`.
    function deposit() public payable {

        //Calling the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        contractBalance = address(this).balance;
    }
    
    //  Defining a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    function setAccounts(address payable account1, address payable account2) public {
        accountOne = account1;
        accountTwo = account2;
    }

    //Adding the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
    function() external payable { }

}