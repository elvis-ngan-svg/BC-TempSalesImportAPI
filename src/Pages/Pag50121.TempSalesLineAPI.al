page 50121 "Temp Sales Line API"
{
    PageType = API;
    Caption = 'Temp Sales Line API';
    APIPublisher = 'elvisngan';
    APIGroup = 'import';
    APIVersion = 'v1.0';
    EntityName = 'tempSalesLine';
    EntitySetName = 'tempSalesLines';
    EntityCaption = 'Temp Sales Line';
    EntitySetCaption = 'Temp Sales Lines'; 
    SourceTable = "Temp Sales Line";
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
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(lineDiscountPercent; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
            }
        }
    }
}
