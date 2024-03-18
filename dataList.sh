#!/bin/bash

# Define the file to store the data
dataFile="dataList.txt"

# Function to display menu options
displayMenu() {
    echo "1. Add new user"
    echo "2. Search for an user"
    echo "3. Sort the list"
    echo "4. Delete a user"
    echo "5. Exit"
}

# Function to add a new user
addUser() {
    echo "Enter first name:"
    read firstName
    echo "Enter last name:"
    read lastName
    echo "Enter ID number:"
    read id

    # Check if the ID already exists
    if grep -q "^$id" "$dataFile"; then
        echo "User with this ID already exists."
    else
        echo "$id . $firstName . $lastName" >> "$dataFile"
        echo "User added successfully."
    fi
}

# Function to search for an user
searchUser() {
    echo "Enter name or ID:"
    read search
    grep -i "$search" "$dataFile"
}

# Function to sort the list
sortList() {
    # Check if the file is empty
    if [ ! -s "$dataFile" ]; then
        echo "The list is empty. There's nothing to sort."
        return
    fi

    echo "Sort by:"
    echo "1. First Name"
    echo "2. Last Name"
    echo "3. ID Number"
    read option

    case $option in
        1) sort -t'|' -k2 "$dataFile";;
        2) sort -t'|' -k3 "$dataFile";;
        3) sort -t'|' -k1 "$dataFile";;
        *) echo "Invalid option";;
    esac
}

# Function that delete a user
deleteUser() {
    echo "Enter ID of the user to delete:"
    read id

    # Check if the ID exists
    if grep -q "^$id \." "$dataFile"; then
        sed -i "/^$id\ \./d" "$dataFile"
        echo "User with ID $id deleted successfully."
    else
        echo "User with ID $id not found."
    fi
}

# Main script

# Check if the data file exists, if not, create it
if [ ! -f "$dataFile" ]; then
    touch "$dataFile"
fi

while true; do
    displayMenu

    read -p "Enter your choice: " choice

    case $choice in
        1) addUser;;
        2) searchUser;;
        3) sortList;;
        4) deleteUser;;
        5) echo "Exiting..."; exit;;
        *) echo "Invalid choice";;
    esac
done
