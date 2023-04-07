---
authors: []
categories: []
date: "2023-04-03"
draft: false
featured: false
image:
  caption: ""
  focal_point: ""
  preview_only: false
lastmod: "2023-03-31T16:03:33-04:00"
projects: []
subtitle: ""
summary: ""
tags: []
title: 'The SQL-Pandas Tango: Streamlining Data Import in Python and R&D'
---

In software R&D, efficiently loading SQL scripts in Python using [`sqlite3`](https://docs.python.org/3/library/sqlite3.html) and importing data into a [Pandas](https://pandas.pydata.org/) [DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html) can be a game-changer.

Consider a scenario where you're developing an AI-driven robot for sorting food products, and your database contains various fruit and vegetable information. Data analysis and preprocessing are crucial to train the robot effectively—this is where Python, Pandas, and SQL work seamlessly together.

## Installing Dependencies

To begin, install the necessary packages: Python, `sqlite3`, and Pandas.

The Python installation instructions can be found [here](https://www.python.org/downloads/).

`sqlite3` is included in the Python standard library, so no additional installation is required.

For Pandas, install it with the following command:

```bash
pip install pandas
```

## Create an SQLite Database

We'll create a straightforward SQLite database with a table containing fruit data for this guide. Save the SQL script below as `fruit_data.sql`:

```sql
CREATE TABLE fruits (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    weight FLOAT,
    color TEXT
);

INSERT INTO fruits (name, weight, color) VALUES ('Apple', 1.2, 'Red');
INSERT INTO fruits (name, weight, color) VALUES ('Banana', 0.2, 'Yellow');
INSERT INTO fruits (name, weight, color) VALUES ('Cherry', 0.01, 'Red');
```

## Execute the SQL Script in Python

Next, create a Python script to load the SQL script and execute it using the `sqlite3` package.

```python
import sqlite3

# load SQL script from file
with open("fruit_data.sql") as f:
    sql = f.read()

# or, load SQL script from string
sql = """
CREATE TABLE fruits (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    weight FLOAT,
    color TEXT
);

INSERT INTO fruits (name, weight, color) VALUES ('Apple', 1.2, 'Red');
INSERT INTO fruits (name, weight, color) VALUES ('Banana', 0.2, 'Yellow');
INSERT INTO fruits (name, weight, color) VALUES ('Cherry', 0.01, 'Red');
"""

# create an in-memory database
connection = sqlite3.connect(":memory:")

# execute SQL script
cursor = connection.cursor()
cursor.executescript(sql)
```

This script generates an in-memory SQLite database, reads the `fruit_data.sql` script, and executes it.

## Load Data into a Pandas DataFrame

Lastly, load data from the SQLite database into a Pandas DataFrame:

```python
import pandas as pd

 # load SQL table into a pandas DataFrame
query = "SELECT * from fruits"
df = pd.read_sql_query(
    sql=query,
    con=connection,
)
```

The generates a Pandas DataFrame from the SQL table with the following:

```bash
   id    name  weight   color
0   1   Apple    1.20     Red
1   2  Banana    0.20  Yellow
2   3  Cherry    0.01     Red
```

## Conclusion

Congratulations! You've successfully loaded an SQL script in Python using `sqlite3` and imported the data into a Pandas DataFrame. Mastering this skill set will undoubtedly be invaluable for data-driven projects in software R&D, allowing you to analyze, preprocess, and manipulate data swiftly.
