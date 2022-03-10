#!/bin/bash


###########################################################################################
#author          :Mateusz Sojka
#script name     :cda.sh
#description     :This is an interactive script used for anonymisation of different tables.
#date            :2022-03-07   
###########################################################################################


##################################CHANGES TO THE SCRIPT###################################
# Author                    Change date                 Description

# Mateusz Sojka             2022-03-08                  Expanded the case for DOB, forename and surname.
# Mateusz Sojka             2022-03-09                  Each SQL to have its own file stored in same DIR.
# Mateusz Sojka			    2022-03-09                  Added a progress bar to each SQL query.

#All the SQLS are stored in the dir where the script is.

#test






#Database selection
echo "Enter the database name: "
read databasename
if [[ -z $databasename ]] ;
then
echo "Provide a database name."
else
echo -e "\e[0;36mUsing $databasename \n\e[0m"
fi

#DB CHECK
if [ ! -d /var/lib/mysql/$databasename ] ; then 
    echo -e "\e[0;36mThe database does NOT exist\n\e[0m"
	echo -e "\e[0;31mEXITING\n\e[0m"
	exit 1
fi


if [[ $1 = "y" ]]; then
cat *.sql | mysql $databasename
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
exit
fi


#Interactive Y/N:


read -r -p "Do you want to anonymise Customer Forename/Surname ? [y/N] " response1
if [[ "$response1" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv forenamesurname.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mCustomer Forename/Surname WILL NOT be anonymised.\n\e[0m"
fi
sleep 0.1


read -r -p "Do you want to anonymise Customer DOB ? [y/N] " response2
if [[ "$response2" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv dob.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	        echo -e "\e[0;36mCustomer DOB WILL NOT be anonymised.\n\e[0m"
	fi
	sleep 0.1


read -r -p "Do you want to anonymise Customer address and postcode ? [y/N] " response3
if [[ "$response3" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv addressNpostcode.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mCustomer address and postcode WILL NOT be anonymised.\n\e[0m"
fi
sleep 0.1


read -r -p "Do you want to anonymise Mortgage address and postcode ? [y/N] " response4
if [[ "$response4" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv mortgageADRnPostcode.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mMortgage address and postcode WILL NOT be anonymised.\n\e[0m"
fi
sleep 0.1


read -r -p "Do you want to anonymise Fact Find answers ? [y/N] " response5
if [[ "$response5" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv ff.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mFact Find answers WILL NOT be anonymised.\n\e[0m"
fi
sleep 0.1


read -r -p "Do you want to anonymise Customer email addresses ? [y/N] " response6
if [[ "$response6" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv email.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mCustomer email addresses WILL NOT be anonymised.\n\e[0m"
fi
sleep 0.1


read -r -p "Do you want to anonymise Customer phone numbers ? [y/N] " response7
if [[ "$response7" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	pv phone.sql | mysql "$databasename"
echo -e "\e[0;36mAnonymisation has been successful.\n\e[0m"
else
	echo -e "\e[0;36mCustomer phone numbers WILL NOT be anonymised.\n\e[0m"
fi
sleep 1

echo -e "\e[0;32mThe database is ready to use.\n\e[0m"
exit
