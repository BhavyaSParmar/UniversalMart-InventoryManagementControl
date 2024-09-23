import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QTableWidget, QTableWidgetItem,QHBoxLayout, QVBoxLayout, QWidget, QPushButton, QLineEdit, QLabel, QMessageBox
import pyodbc
from PyQt5.QtGui import QColor
from PyQt5.QtGui import QFont


class WholeSaleManagementSystem(QMainWindow):
    def __init__(self):
        super().__init__()
        connection_string = "Driver=SQL Server;Server=ANSH\SQLEXPRESS;Database=WholeSale Management System; Trusted_Connection=Yes"

        self.connection = pyodbc.connect(connection_string)
        self.setWindowTitle("Wholesale Management System")
        self.setGeometry(100, 100, 800, 600)
        self.setFont(QFont("Arial", 12))  # Set a custom font for labels
        self.setContentsMargins(0, 0, 10, 0)  # Add right margin for spacing
        self.create_widgets()
       

    def create_widgets(self):
        self.table = QTableWidget(self)
        self.table.setColumnCount(10)  
        self.table.setHorizontalHeaderLabels(["Customer_ID", "First_Name", "Last_Name", "Email_ID","Phone_Number","Customer_Street",
                                              "Customer_City","Customer_State","Customer_Status","Join_Date"])
        

        # Create input fields for adding and updating data
        self.Customer_ID_entry = QLineEdit(self)
        self.First_Name_entry = QLineEdit(self)
        self.Last_Name_entry = QLineEdit(self)
        self.Email_ID_entry = QLineEdit(self)
        self.Phone_Number_entry = QLineEdit(self)
        self.Customer_Street_entry = QLineEdit(self)
        self.Customer_City_entry = QLineEdit(self)
        self.Customer_State_entry = QLineEdit(self)
        self.Customer_Status_entry = QLineEdit(self)
        self.Join_Date_entry = QLineEdit(self)

      
        Customer_ID_label = QLabel("Customer_ID:", self)
        First_Name_label = QLabel("First_Name:", self)
        Last_Name_label = QLabel("Last_Name:", self)
        Email_ID_label = QLabel("Email_ID:", self)
        Phone_Number_label = QLabel("Phone_Number:", self)
        Customer_Street_label = QLabel("Customer_Street:", self)
        Customer_City_label = QLabel("Customer_City:", self)
        Customer_State_label = QLabel("Customer_State:", self)
        Customer_Status_label = QLabel("Customer_Status:", self)
        Join_Date_label = QLabel("Join_Date:", self)

        add_button = QPushButton("Add Customer", self)
        update_button = QPushButton("Update Customer", self)
        delete_button = QPushButton("Delete Customer", self)

        # Set up layout
        layout = QHBoxLayout()
        fieldLayout = QVBoxLayout()
        layout.addWidget(self.table)
        fieldLayout.addWidget(Customer_ID_label)
        fieldLayout.addWidget(self.Customer_ID_entry)
        fieldLayout.addWidget(First_Name_label)
        fieldLayout.addWidget(self.First_Name_entry)
        fieldLayout.addWidget(Last_Name_label)
        fieldLayout.addWidget(self.Last_Name_entry)
        fieldLayout.addWidget(Email_ID_label)
        fieldLayout.addWidget(self.Email_ID_entry)
        fieldLayout.addWidget(Phone_Number_label)
        fieldLayout.addWidget(self.Phone_Number_entry)
        fieldLayout.addWidget(Customer_Street_label)
        fieldLayout.addWidget(self.Customer_Street_entry)
        fieldLayout.addWidget(Customer_City_label)
        fieldLayout.addWidget(self.Customer_City_entry)
        fieldLayout.addWidget(Customer_State_label)
        fieldLayout.addWidget(self.Customer_State_entry)
        fieldLayout.addWidget(Customer_Status_label)
        fieldLayout.addWidget(self.Customer_Status_entry)
        fieldLayout.addWidget(Join_Date_label)
        fieldLayout.addWidget(self.Join_Date_entry)
        fieldLayout.addWidget(add_button)
        fieldLayout.addWidget(update_button)
        fieldLayout.addWidget(delete_button)
        self.Customer_ID_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.First_Name_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Last_Name_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Email_ID_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Phone_Number_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Customer_Street_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Customer_City_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Customer_State_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Customer_Status_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.Join_Date_entry.setStyleSheet(f"background-color: #a5b1b5; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")
        self.set_button_style(add_button, "#4CAF50")  # Green
        self.set_button_style(update_button, "#091f91")  # Yellow
        self.set_button_style(delete_button, "#F44336")  # Red
        layout.addLayout(fieldLayout)
        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)
        add_button.clicked.connect(self.add_customer)
        update_button.clicked.connect(self.update_customer)
       # delete_button.clicked.connect(self.delete_customer)

        # Load data on startup
        self.load_data()


        # ... (your existing code)

    def set_button_style(self, button, color):
        button.setStyleSheet(f"background-color: {color}; color: white;border-radius: 15px;border: 1px solid #888888; padding: 5px;font-size: 20px")

    def load_data(self):
        try:
            cursor = self.connection.cursor()
            cursor.execute('Select Customer_ID, First_Name, Last_Name, Email_ID, Phone_Number, Customer_Street, Customer_City, Customer_State, Customer_Status, Join_Date from Customer')
            rows = cursor.fetchall()

            
            self.table.setRowCount(0)

          
            for row_num, row_data in enumerate(rows):
                self.table.insertRow(row_num)
                for col_num, col_data in enumerate(row_data):
                    item = QTableWidgetItem(str(col_data))
                    self.table.setItem(row_num, col_num, item)

        except Exception as e:
            QMessageBox.critical(self, "Error", f"Error loading data: {str(e)}")
        finally:
            cursor.close()

    def add_customer(self):
        try:
            new_values = (
                self.Customer_ID_entry.text(),
                self.First_Name_entry.text(),
                self.Last_Name_entry.text(),
                self.Email_ID_entry.text(),
                self.Phone_Number_entry.text(),
                self.Customer_Street_entry.text(),
                self.Customer_City_entry.text(),
                self.Customer_State_entry.text(),
                self.Customer_Status_entry.text(),
                self.Join_Date_entry.text()
            )

            cursor = self.connection.cursor()
            cursor.execute(
                "INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email_ID, Phone_Number, Customer_Street, Customer_City, Customer_State, Customer_Status, Join_Date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                new_values
            )
            self.connection.commit()

            # After adding, refresh the data
            self.load_data()

        except Exception as e:
            QMessageBox.critical(self, "Error", f"Error adding ward: {str(e)}")

    def update_customer(self):
        cus_id = self.Customer_ID_entry.text()
        new_values = (
            self.First_Name_entry.text(),
            self.Last_Name_entry.text(),
            self.Email_ID_entry.text(),
            self.Phone_Number_entry.text(),
            self.Customer_Street_entry.text(),
            self.Customer_City_entry.text(),
            self.Customer_State_entry.text(),
            self.Customer_Status_entry.text(),
            self.Join_Date_entry.text()
        )

        try:
            cursor = self.connection.cursor()
            cursor.execute(
                "UPDATE Customer SET First_Name=?, Last_Name=?, Email_ID=?, Phone_Number=?, Customer_Street=?, Customer_City=?, Customer_State=?, Customer_Status=?, Join_Date=? WHERE Customer_ID=?",
                (*new_values, cus_id)
            )
            self.connection.commit()

            # After updating, refresh the data
            self.load_data()

        except Exception as e:
            QMessageBox.critical(self, "Error", f"Error updating ward: {str(e)}")

    def delete_customer(self):
        cus_id = self.Customer_ID_entry.text()
        if cus_id:
            try:
                cursor = self.connection.cursor()
                cursor.execute("DELETE FROM Customer WHERE Customer_ID=?", cus_id)
                self.connection.commit()

                # After deleting, refresh the data
                self.load_data()

            except Exception as e:
                QMessageBox.critical(self, "Error", f"Error deleting ward: {str(e)}")


if __name__=='__main__':
    app = QApplication(sys.argv)
    window = WholeSaleManagementSystem()
    window.show()
    sys.exit(app.exec_())