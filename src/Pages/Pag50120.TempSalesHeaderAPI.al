page 50120 "Temp Sales Header API"
{
    PageType = API;
    Caption = 'Temp Sales Header API';
    APIPublisher = 'elvisngan';
    APIGroup = 'import';
    APIVersion = 'v1.0';
    EntityName = 'tempSalesHeader';
    EntitySetName = 'tempSalesHeaders'; 
    EntityCaption = 'Temp Sales Header';
    EntitySetCaption = 'Temp Sales Headers';
    SourceTable = "Temp Sales Header";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    Editable = false;
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.';
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name';
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date';
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                    Editable = false;
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                    Editable = false;
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                    Editable = false;
                }
                field(processedDocumentNo; Rec."Processed Document No.")
                {
                    Caption = 'Processed Document No.';
                    Editable = false;
                }
                field(processedDocumentType; Rec."Processed Document Type")
                {
                    Caption = 'Processed Document Type';
                    Editable = false;
                }

                part(tempSalesLines; "Temp Sales Line API")
                {
                    Caption = 'Temp Sales Lines';
                    EntityName = 'tempSalesLine';
                    EntitySetName = 'tempSalesLines';
                    SubPageLink = "Entry No." = field("Entry No.");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::New;
        exit(true);
    end;
}
