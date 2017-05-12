#!/bin/bash
# Create herox.RData in current folder
# Create .emails.csv in original data folder
Rscript create_contact_list.R > create_contact_list.Rout 2> create_contact_list.Rerr

# Contacts for profiles with bio
Rscript create_contact_list_profiles.R > create_contact_list_profiles.Rout 2> create_contact_list_profiles.Rerr

