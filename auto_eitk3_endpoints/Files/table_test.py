from interface.script.translation_script import TranslationScript
from interface.script.script_information import ScriptInformation, EitkApiVersion
from eitk_api.tables.table_helper import TableHelper, TableColumn
from eitk_api.eitk_exception import EitkException
import io
import sys

TABLE_NAME = 'TEST TABLE 1'
COLUMN_1 = TableColumn('1', '1', 'Key')
COLUMN_2 = TableColumn('2', '2', 'Unique')
COLUMN_3 = TableColumn('3', '3', 'None')
TABLE_COLUMNS = [
    COLUMN_1,
    COLUMN_2,
    COLUMN_3
]

COLUMN_4 = TableColumn('4', '4', 'None')

"""
Get a table from EITK
"""
class Runner(TranslationScript):
    """
    Get a table
    """

    def __init__(self, task_info):
        super().__init__(task_info)
        # Initialize EITK RDBMS API helper. This object handles calls to rdbms
        self.table_helper = TableHelper()

    def get_information(self):
        # Tell EITK what version of the API to run
        script_info = ScriptInformation()
        script_info.set_version(EitkApiVersion.v2_0_4_0)
        return script_info

    def run(self, step_info):
        """
        Get a table by name
        """

        # Test Create Table
        table = self.table_helper.create_table(TABLE_NAME, TABLE_COLUMNS)

        test_create_2 = self.table_helper.create_table(TABLE_NAME, TABLE_COLUMNS)
        if test_create_2:
            raise ValueError('Create Table - Duplicate Table Created')

        columns = table.get_columns()
        if len(columns) != len(TABLE_COLUMNS):
            raise ValueError("Create Table - Columns size mismatch")

        for column in columns:
            matched = False
            for expected in TABLE_COLUMNS:
                if expected.id == column.id:
                    matched = True
                    if expected.name != column.name or expected.type != column.type:
                        raise ValueError('Create Table - Column Data')
            if not matched:
                raise ValueError('Create Table - Unknown Column')

        # Test Get Table
        if table.id != self.table_helper.get_table(TABLE_NAME).id:
            raise ValueError("Get Table - Not Found")
        if self.table_helper.get_table("table that doesn't exist"):
            raise ValueError("Get Table - Found Non-Existing Table")

        # Test Get Tables
        if table.id != self.table_helper.get_tables(filter=['id', '=', TABLE_NAME], limit=1)[0].id:
            raise ValueError("Get Tables - Not Found")

        # Test Add Column
        table.add_column(COLUMN_4)
        col4 = table.get_column(COLUMN_4.id)
        if not col4:
            raise ValueError('Add Column - Not Added')
        if COLUMN_4.id != col4.id or COLUMN_4.name != col4.name or COLUMN_4.type != col4.type:
            raise ValueError('Add Column - Incorrect Data')

        # Test Replace Column
        COL4_UPDATE_NAME = 'TEST'
        table.replace_column(TableColumn(COLUMN_4.id, COL4_UPDATE_NAME))
        col4 = table.get_column(COLUMN_4.id)
        if not col4:
            raise ValueError('Replace Column - Not Found')
        if COLUMN_4.id != col4.id or COL4_UPDATE_NAME != col4.name or COLUMN_4.type != col4.type:
            raise ValueError('Replace Column - Incorrect Data')

        # Test Delete Column
        table.delete_column(COLUMN_4.id)
        if table.get_column(COLUMN_4.id):
            raise ValueError('Delete Column - Not Deleted')

        # Test Add Row
        ROW_KEY = '1'
        row = table.create_row({ '1': ROW_KEY, '2': '2', '3': '3' })
        if not row:
            raise ValueError('Add Row - Not Added')
        if row['1'] != '1' or row['2'] != '2' or row['3'] != '3':
            raise ValueError('Add Row - Incorrect Data')

        # Test Update Row
        ROW_UPDATED_VALUE = 'a'
        table.update_row(ROW_KEY, { '2': ROW_UPDATED_VALUE })
        row = table.get_row(ROW_KEY)
        if not row:
            raise ValueError('Update Row - Not Found')
        if row['2'] != ROW_UPDATED_VALUE:
            raise ValueError('Update Row - Not Updated')

        # Test Update Rows
        ROW_UPDATED_VALUE = 'b'
        table.update_rows({ '2': ROW_UPDATED_VALUE }, filter=['key', '=', ROW_KEY])
        row = table.get_row(ROW_KEY)
        if not row:
            raise ValueError('Update Rows - Not Found')
        if row['2'] != ROW_UPDATED_VALUE:
            raise ValueError('Update Rows - Not Updated')

        # Test Delete Row
        table.delete_row(ROW_KEY)
        row = table.get_row(ROW_KEY)
        if row:
            raise ValueError('Delete Row - Not Deleted')

        # Test Delete Rows
        table.create_row({'1': '1'})
        table.create_row({'1': '2'})
        if 2 != len(table.get_rows()):
            raise ValueError('Delete Rows - Rows Not Created')
        table.delete_rows()
        if 0 != len(table.get_rows()):
            raise ValueError('Delete Rows - Rows Not Deleted')

        # Test Delete Table
        self.table_helper.delete_table(TABLE_NAME)

        if len(self.table_helper.get_tables(filter=['id', '=', TABLE_NAME])) != 0:
            raise ValueError("Delete Tables - Still Exists")

        return 0
