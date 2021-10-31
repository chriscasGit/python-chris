#import libraries
import win32com.client as win32
import os
from pandas import *
import sys
import time

#create system variables
t = time.localtime()
timestamp = time.strftime('%Y%B%d_%H%M%S', t)
cwd = os.getcwd()
outlook = win32.Dispatch('outlook.application')
sys.stdout = open(cwd+"\\"+"_log_"+timestamp+".txt", 'w')

#import excel file
path = cwd+"\\"+"_email_setup.xlsx"
xls = ExcelFile(path)
df = xls.parse(xls.sheet_names[0],index_col=False)

#loop to create emails
for index, row in df.iterrows():      

    try:        
        mail = outlook.CreateItem(0)
        mail.To = row["partner_emails"]
        mail.Subject = row["email_subject"]
        mail.Body = row["email_body"]
        mail.Display(False)
        
        #checks if there is more than one attachment. always separate by ; or will not recognize more files
        if ";" in row["email_attachment_name"]:
            row["email_attachment_split"] = row["email_attachment_name"].split(';')
            for i in row["email_attachment_split"]:
                attachment = cwd+"\\"+i.strip()
                mail.Attachments.Add(attachment)
                           
        else:
            attachment = cwd+"\\"+row["email_attachment_name"]
            mail.Attachments.Add(attachment)
        print("OK partner done: " + row["partner_name"])
        
    except:
        print("CHECK ERROR partner: "+row["partner_name"])

sys.stdout.close()
