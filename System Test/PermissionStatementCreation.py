import pandas as pd

# Load the CSV file
file_path = 'userPermisssions.csv'
permissions_df = pd.read_csv(file_path)

# Function to generate SQL statements
def generate_sql_statements(permissions_df):
    sql_statements = []

    for index, row in permissions_df.iterrows():
        procedure_function = row['Procedure / Function']
        
        for user_role in ['Admin1', 'TrainingManager1', 'Instructor1', 'Student1']:
            permission = row[user_role]
            if permission == 'GRANT':
                sql_statements.append(f"GRANT EXECUTE ON OBJECT::{procedure_function} TO {user_role};")
            elif permission == 'DENY':
                sql_statements.append(f"DENY EXECUTE ON OBJECT::{procedure_function} TO {user_role};")

    return sql_statements

# Generate SQL statements
sql_statements = generate_sql_statements(permissions_df)

# Print SQL statements
for statement in sql_statements:
    print(statement)
