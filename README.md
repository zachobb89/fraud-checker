The task
-
Build a fraud detector in Ruby that checks if any of the following two match:

Last name and postcode.

Last name and both last 4 digits of card & expiry dates (in different formats).

Postcode and both last 4 digits of card & expiry dates (in different formats).

My solution
-
The FraudDetector Class initialized with a last_name, postcode, card_number & card_expiry. Some dummy users have been added to the class in an array to check whether the system works. 

When fraudulent? is called on the instance of FraudDetector it first checks if the last_name and card details match. It does this by finding matching last_name's in the users array with the last_name that is in the FraudDetector instance. These instances are then passed to the card_with_expiry method which then selects the instances that have a matching card_number. These instances are then iterated through to find matching expiry_dates. These are then returned as a count. 

Similar methodology is used for the other two checks. 

The fraudulent? method then checks the counts of each of the three conditions and if there are matched returns true and false if there are no matches. 

I feel the system is robust. It reformats the variables so that matches can be found if the variables are inputted in any format. 

Areas for improvement
-
It may be benificial to check if all three conditions match. It could be possible that a user could have the same surname and matching card details if you had a huge amount of users. 
