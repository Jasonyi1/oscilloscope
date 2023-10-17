from PyQt6.QtWidgets import QApplication, QWidget, QTextEdit, QVBoxLayout, QPushButton, QFileDialog, QLabel, QHBoxLayout, QMessageBox, QLineEdit, QTableWidget, QTableWidgetItem
import serial
import sys
import os


class UsrtController(QWidget):
    def __init__(self):
        super().__init__()
        self.reader = []
        self.setWindowTitle('FPGA插值滤波器系数更改上位机')

        self.resize(600, 150)
        
        self.btn_open_file = QPushButton('从文件中获取系数')
        self.btn_send_coef = QPushButton('发送系数')
        
        self.vbox_layout = QVBoxLayout()
        self.vbox_layout.addWidget(self.btn_open_file)
        self.vbox_layout.addWidget(self.btn_send_coef)
        
        self.info_table = QTableWidget()
        
        self.hbox_layout = QHBoxLayout()
        self.hbox_layout.addLayout(self.vbox_layout)
        self.hbox_layout.addWidget(self.info_table)

        self.setLayout(self.hbox_layout)

        self.btn_open_file.clicked.connect(self.btn_open_file_clicked)
        self.btn_send_coef.clicked.connect(self.btn_send_coef_clicked)

    # def create_reader(self):
        # if os.path.splitext(self.path_text_edit.toPlainText())[-1] == '.csv':
        #     self.reader = CsvInfoReader(self.path_text_edit.toPlainText())
        # elif os.path.splitext(self.path_text_edit.toPlainText())[-1] == '.zip':
        #     self.reader = ZipInfoReader(self.path_text_edit.toPlainText(), self.zippedfile_name_text_edit.text())
        # else:
        #     self.reader = TextInfoReader(self.path_text_edit.toPlainText())
            
    def btn_open_file_clicked(self):
        file_path = QFileDialog.getOpenFileName(None, "Choose File", "./", "*.csv;")[0]
        self.create_reader()
            
    # def find_survivor_btn_clicked(self):
    #     if (self.path_text_edit.document().isEmpty()):
    #         QMessageBox.critical(self, "错误", "请选择正确的路径", QMessageBox.StandardButton.Close)
    #         return
        
    #     self.create_reader()
            
        
    def btn_send_coef_clicked(self):
        try:
            self.create_reader()
            total_number = self.reader.get_total_number()
            self.info_table.clear()
            self.info_table.setRowCount(total_number)
            self.info_table.setColumnCount(2)
            self.info_table.setHorizontalHeaderLabels(['姓名', '年龄'])
            for i in range(total_number):
                person = self.reader.read_person(i)
                self.info_table.setItem(i, 0, QTableWidgetItem(person.name))
                self.info_table.setItem(i, 1, QTableWidgetItem(str(person.age)))
        except AttributeError:
            QMessageBox.critical(self, "错误", "未打开文件", QMessageBox.StandardButton.Close)


if __name__ == '__main__':
    # log_config()
    app = QApplication(sys.argv)
    win = UsrtController()
    win.show()
    sys.exit(app.exec())