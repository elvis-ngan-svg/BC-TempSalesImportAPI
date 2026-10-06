table 50110 "Temp Sales Header"
{
    Caption = 'Temp Sales Header';
    DataClassification = CustomerContent;
    LookupPageId = "Temp Sales Order List";
    DrillDownPageId = "Temp Sales Order List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "External Document No."; Code[35])
        {
            Caption = 'External Document No.'; 
        }
        field(3; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer."No.";
        }
        field(4; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Sell-to Customer Name';
        }
        field(5; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(7; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Ready,Processed,Error;
            OptionCaption = 'New,Ready,Processed,Error';
            Editable = false;
        }
        field(9; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            Editable = false;
        }
        field(10; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(11; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
        field(12; "Processed Document No."; Code[20])
        {
            Caption = 'Processed Document No.';
            Editable = false;
        }
        field(13; "Processed Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Processed Document Type';
            Editable = false;
        }
        field(14; SystemId; Guid)
        {
            Caption = 'SystemId';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ExternalDoc; "External Document No.")
        {
        }
        key(StatusKey; Status)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created DateTime" := CurrentDateTime();
        Status := Status::New;
    end;

    trigger OnDelete()
    var
        TempSalesLine: Record "Temp Sales Line";
    begin
        TempSalesLine.SetRange("Entry No.", "Entry No.");
        TempSalesLine.DeleteAll(true);
    end;
}
