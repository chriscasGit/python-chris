from zipfile import ZipFile
import time

#create time stamp to save files with unique names
t = time.localtime()
timestamp = time.strftime('%Y%B%d_%H%M%S', t)

#give the directory of files you want to bacup
file1 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW21\RangePlan\FW21 RP SOUTH LAST.xlsb"
file2 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\SS22\range_plan\SS22_RP_SOUTH_LAST.xlsb"
file3 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW22\FW22_RP_SOUTH_LAST.xlsb"

file4 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW21\RangePlan\SA\SA_DB_FW21.accdb"
file5 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\SS22\range_plan\SA tab\SA_DB_SS22.accdb"
file6 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW22\SA\TOOL_SA_FW22.accdb"


file7 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW21\RangePlan\SA\FW21_sa_extract_live.xlsx"
file8 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW21\RangePlan\SA\FW21_sa_summary_allocation.xlsx"
file9 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\SS22\range_plan\SA tab\SS22_sa_extract_live.xlsx"
file10 = r"\\levi.com\ls\Regional\LSE\BRU\DATA\ALL\RETAIL TRADING PODS\SOUTH\Planning\FW22\SA\FW22_sa_extract_live.xlsx"

#create list with all files you want to backup
file_list = [file1, file2, file3, file4, file5, file6, file7, file8, file9, file10]
print("script started...")

# create a ZipFile object
zipObj = ZipFile('Backups_Planning' + timestamp + '.zip', 'w')
# Add multiple files to the zip
for file in file_list:
    zipObj.write(file)
    print("Zip done for file: " + file)


print("all files zipped!")
# close the Zip File
zipObj.close()
