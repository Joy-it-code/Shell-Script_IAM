#!/bin/bash

# Define IAM User Names Array
IAM_USERS=("Alice" "Bob" "Charlie" "Dave" "Eve")

# Iterate through the IAM users array and create IAM users
for user in "${IAM_USERS[@]}"; do
  echo "Creating IAM user: $user"
  aws iam create-user --user-name "$user"

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully created IAM user: $user"
  else
    echo "Failed to create IAM user: $user"
  fi
done

# Function to create IAM group
create_iam_group() {
  local group_name="admin"

  echo "Creating IAM group: $group_name"
  aws iam create-group --group-name "$group_name"

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully created IAM group: $group_name"
  else
    echo "Failed to create IAM group: $group_name"
  fi
}

# Call the function to create the IAM group
create_iam_group

# Function to attach AdministratorAccess policy to the group
attach_admin_policy() {
  local group_name="admin"
  local policy_arn="arn:aws:iam::aws:policy/AdministratorAccess"

  echo "Attaching AdministratorAccess policy to group: $group_name"
  aws iam attach-group-policy --group-name "$group_name" --policy-arn "$policy_arn"

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully attached AdministratorAccess policy to group: $group_name"
  else
    echo "Failed to attach AdministratorAccess policy to group: $group_name"
  fi
}

# Create the admin group
create_iam_group

# Attach the AdministratorAccess policy to the admin group
attach_admin_policy

# Function to add users to the admin group
assign_users_to_group() {
  local group_name="admin"

  for user in "${IAM_USERS[@]}"; do
    echo "Assigning user $user to group $group_name"
    aws iam add-user-to-group --group-name "$group_name" --user-name "$user"

    # Check if the command succeeded
    if [ $? -eq 0 ]; then
      echo "Successfully assigned user $user to group $group_name"
    else
      echo "Failed to assign user $user to group $group_name"
    fi
  done
}

# Create the admin group
create_iam_group

# Attach the AdministratorAccess policy to the admin group
attach_admin_policy

# Assign each user to the admin group
assign_users_to_group