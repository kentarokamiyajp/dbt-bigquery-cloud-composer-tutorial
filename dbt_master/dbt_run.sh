#!/bin/bash

# activate dbt environment
echo "activating venv..."
. ~/venv/bin/activate
is_activated=$?
if [ $is_activated != 0 ]; then
    echo "Failed to activate venv"
else
    echo "Activated !!!"
fi

# run the dbt commnad
echo "running dbt task..."
cd ~/dbt_pj/test
dbt run
dbt_status=$?
if [ $dbt_status != 0 ]; then
    echo "Failed to execute dbt run"
else
    echo "finished dbt task !!!"
fi

# deactiavte the venv
echo "deactivating venv..."
deactivate
is_dectivated=$?
if [ $is_dectivated != 0 ]; then
    echo "Failed to deactivate venv"
else
    echo "Deactivate !!!"
fi
