table 50111 "Temp Sales Line"
{
    Caption = 'Temp Sales Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            TableRelation = "Temp Sales Header"."Entry No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Enum "Sales Line Type")
        {
            Caption = 'Type'; 
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
        }
        field(8; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(10; SystemId; Guid)
        {
            Caption = 'SystemId';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
