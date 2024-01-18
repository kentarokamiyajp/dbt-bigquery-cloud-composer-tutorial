from datetime import timedelta, datetime
from airflow import DAG
from airflow.contrib.hooks.ssh_hook import SSHHook
from airflow.contrib.operators.ssh_operator import SSHOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.providers.google.cloud.hooks.compute_ssh import ComputeEngineSSHHook


dag_id = "run_dbt_by_ssh_operator"
tags = ["DBT"]
args = {"owner": "airflow", "retries": 0, "retry_delay": timedelta(minutes=10)}

with DAG(
    dag_id,
    description="Run dbt",
    schedule_interval=None,
    start_date=datetime(2023, 1, 1),
    catchup=False,
    tags=tags,
    default_args=args,
) as dag:
    dag_start = DummyOperator(task_id="dag_start")

    # There are two way to run DBT tasks from composer.
    # (The shell to run a dbt command needed to be prepared on the dbt-master instance in advance)

    """
    Method-1: SSHOperator & ComputeEngineSSHHook
    """
    run_dbt_by_ComputeEngineSSHHook = SSHOperator(
        task_id="run_dbt_by_ComputeEngineSSHHook",
        ssh_hook=ComputeEngineSSHHook(
            instance_name="dbt-master",
            zone="<zone>",  # Replace to yours
            project_id="<project_id>",  # Replace to yours
            user="<username>",  # Replace to yours
            use_oslogin=False,
            use_iap_tunnel=False,
            use_internal_ip=False,
        ),
        command=" sh ~/dbt_pj/test/dbt_debug.sh ",
        dag=dag,
    )

    """
    Method-2: SSHOperator & SSSHook
        This method needs to create a SSH key and put private key file 
        on GCS bucket connected to the composer instance.
        In this case, the file is stored in '/home/airflow/gcs/dags/ssh_config/id_rsa_composer', where the dags folder is located on cloud storage.
        Additionally, you need to register the public key into the authorized_keys on GCE instance(dbt-master).
    """
    run_dbt_by_SSHHook = SSHOperator(
        task_id="run_dbt_by_SSHHook",
        ssh_hook=SSHHook(
            remote_host="<dbt-master_host>", # Replace to yours
            username="<username>", # Replace to yours
            key_file="/home/airflow/gcs/dags/ssh_config/id_rsa_composer",
            port=22,
        ),
        command=" sh ~/dbt_pj/test/dbt_debug.sh ",
        dag=dag,
    )

    dag_end = DummyOperator(task_id="dag_end")

    (dag_start >> run_dbt_by_ComputeEngineSSHHook >> run_dbt_by_SSHHook >> dag_end)
