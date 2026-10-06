# Business Central – Temp Sales Order Import API

A clean, production-ready **Custom API + Staging Table** solution for Microsoft Dynamics 365 Business Central.

---

<img width="1168" height="784" alt="dO3Ie" src="https://github.com/user-attachments/assets/3d36e17b-0ba2-4596-92c6-db2825ff950f" />
<img width="1168" height="784" alt="tjhxd" src="https://github.com/user-attachments/assets/5ee62e1b-3160-4873-a082-9aee7a46746c" />
<img width="1168" height="784" alt="9AaJs" src="https://github.com/user-attachments/assets/ced69140-ef57-4579-8801-20a3706579bc" />
<img width="1168" height="784" alt="rNpmK" src="https://github.com/user-attachments/assets/2ae7e252-5522-4b62-9e50-44773916f2a7" />



---

## Business Flow

```
External System (cleaned data)
        │
        ▼  POST (Custom API)
┌─────────────────────────────┐
│  Temp Sales Header + Lines  │  ← Staging Tables
│  Status: New → Ready        │
└─────────────────────────────┘
        │
        ▼  Manual action by user
┌─────────────────────────────┐ 
│  Create Sales Order         │
│  or Create Sales Quote      │
└─────────────────────────────┘
        │
        ▼
Real Sales Header / Sales Line
(Status becomes Processed)
```

---

## Features

- Custom OData API (`PageType = API`) for importing Header + Lines in one request
- Staging tables (`Temp Sales Header` / `Temp Sales Line`) with status workflow
- User-friendly List + Card pages for review and conversion
- One-click conversion to **Sales Order** or **Sales Quotation**
- Proper permission set

---

## API Endpoint

After publishing the extension:

```
POST https://api.businesscentral.dynamics.com/v2.0/{tenant}/{environment}/api/elvisngan/import/v1.0/companies({companyId})/tempSalesHeaders
```

### Example Request Body (Header + Lines)

```json
{
  "externalDocumentNo": "EXT-2025-001",
  "sellToCustomerNo": "10000",
  "sellToCustomerName": "Adatum Corporation",
  "orderDate": "2025-10-06",
  "documentDate": "2025-10-06",
  "currencyCode": "",
  "tempSalesLines": [
    {
      "lineNo": 10000,
      "type": "Item",
      "number": "1896-S",
      "description": "ATHENS Desk",
      "quantity": 2,
      "unitPrice": 1000,
      "lineDiscountPercent": 0,
      "locationCode": ""
    },
    {
      "lineNo": 20000,
      "type": "Item",
      "number": "1900-S",
      "description": "PARIS Guest Chair, black",
      "quantity": 4,
      "unitPrice": 192.8,
      "lineDiscountPercent": 5,
      "locationCode": ""
    }
  ]
}
```

---

## Objects Included

| Type       | ID    | Name                        | Description                          |
|------------|-------|-----------------------------|--------------------------------------|
| Table      | 50110 | Temp Sales Header           | Staging header                       |
| Table      | 50111 | Temp Sales Line             | Staging lines                        |
| Page (API) | 50120 | Temp Sales Header API       | Main import endpoint                 |
| Page (API) | 50121 | Temp Sales Line API         | Lines endpoint                       |
| Page       | 50130 | Temp Sales Order List       | User review list                     |
| Page       | 50131 | Temp Sales Order Card       | User review card                     |
| Page       | 50132 | Temp Sales Lines Subpage    | Lines on card                        |
| Codeunit   | 50120 | Temp Sales Order Mgt        | Conversion logic                     |
| Permission | 50100 | Temp Sales Import API       | Assignable permission set            |

---

## How to Use

1. **Publish** the extension to your BC Sandbox / Environment
2. Assign the permission set **Temp Sales Import API** to the relevant users / service principals
3. Call the API from Postman / Azure Logic Apps / Power Automate / custom app
4. Open **Temp Sales Orders** page in BC
5. Review data → **Mark as Ready** → **Create Sales Order** or **Create Sales Quote**

---

## Project Structure

```
BC-TempSalesImportAPI/
├── app.json
├── README.md
├── .gitignore
└── src/
    ├── Tables/
    │   ├── Tab50110.TempSalesHeader.al
    │   └── Tab50111.TempSalesLine.al
    ├── Pages/
    │   ├── Pag50120.TempSalesHeaderAPI.al
    │   ├── Pag50121.TempSalesLineAPI.al
    │   ├── Pag50130.TempSalesOrderList.al
    │   ├── Pag50131.TempSalesOrderCard.al
    │   └── Pag50132.TempSalesLinesSubpage.al
    ├── Codeunits/
    │   └── Cod50120.TempSalesOrderMgt.al
    └── Permissions/
        └── PermissionSet50100.TempSalesImportAPI.al
```

## License

MIT – free to use for learning and portfolio purposes.

---

**Author**: Elvis Ngan  
**GitHub**: [ElvisNgan](https://github.com/ElvisNgan)  
**Role**: Dynamics 365 Business Central Developer  
