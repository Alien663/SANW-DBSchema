# SANW-DBSchema
使用北風資料庫做為基礎，以此建立會員系統，資料可以參考微軟提供的github專案 : [microsoft/sql-server-samples](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs)

## Build DB
### 基於北風資料庫建立
本專案使用C#的SQL專案匯出資料庫的Schema進行版控，如要建置SANW的資料庫系統，請依照以下步驟:
1. 使用微軟github提供的script建立基本的北風資料庫
2. 使用Visual Studio開啟本專案
3. 將本專案設為來源，北風資料庫設為目標
4. 使用結構描述比較，比對本專案與北風資料庫
5. 使用更新將專案Schema部屬至目標的北風資料庫
6. 資料庫部屬完成

### 直接匯入Schema
透過以上方式，雖然步驟複雜，但可以確保帶到北風資料庫的所有資料，當然可以直接透過資料庫的dacpac檔案直接建立資料庫，但步驟簡單的同時卻無法夾帶北風資料庫內的資料，其步驟如下
1. 使用Visual Studio開啟本專案
2. 建置專案，產生dacpac檔案 : `\Schema\bin\Debug\Schema.dacpac`
3. 開啟SSMS，選擇匯入資料應用層
4. 資料庫部屬完成