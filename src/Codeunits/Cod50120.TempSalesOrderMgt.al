codeunit 50120 "Temp Sales Order Mgt"
{
    procedure CreateSalesDocument(var TempSalesHeader: Record "Temp Sales Header"; DocumentType: Enum "Sales Document Type")
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Temp Sales Line";
        LineNo: Integer; 
    begin
        if TempSalesHeader.Status = TempSalesHeader.Status::Processed then
            Error('This document has already been processed. Document No.: %1', TempSalesHeader."Processed Document No.");

        if TempSalesHeader.Status <> TempSalesHeader.Status::Ready then
            Error('Only documents with status Ready can be converted. Current status: %1', TempSalesHeader.Status);

        if TempSalesHeader."Sell-to Customer No." = '' then
            Error('Sell-to Customer No. must be filled in before creating a Sales Document.');

        // Create Sales Header
        SalesHeader.Init();
        SalesHeader."Document Type" := DocumentType;
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", TempSalesHeader."Sell-to Customer No.");

        if TempSalesHeader."Sell-to Customer Name" <> '' then
            SalesHeader."Sell-to Customer Name" := TempSalesHeader."Sell-to Customer Name";

        if TempSalesHeader."Order Date" <> 0D then
            SalesHeader.Validate("Order Date", TempSalesHeader."Order Date")
        else
            SalesHeader.Validate("Order Date", WorkDate());

        if TempSalesHeader."Document Date" <> 0D then
            SalesHeader.Validate("Document Date", TempSalesHeader."Document Date")
        else
            SalesHeader.Validate("Document Date", WorkDate());

        if TempSalesHeader."Currency Code" <> '' then
            SalesHeader.Validate("Currency Code", TempSalesHeader."Currency Code");

        SalesHeader."External Document No." := TempSalesHeader."External Document No.";
        SalesHeader.Modify(true);

        // Create Sales Lines
        TempSalesLine.SetRange("Entry No.", TempSalesHeader."Entry No.");
        if TempSalesLine.FindSet() then
            repeat
                LineNo += 10000;

                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.Insert(true);

                SalesLine.Validate(Type, TempSalesLine.Type);

                if TempSalesLine."No." <> '' then
                    SalesLine.Validate("No.", TempSalesLine."No.");

                if TempSalesLine.Description <> '' then
                    SalesLine.Validate(Description, TempSalesLine.Description);

                SalesLine.Validate(Quantity, TempSalesLine.Quantity);
                SalesLine.Validate("Unit Price", TempSalesLine."Unit Price");

                if TempSalesLine."Line Discount %" <> 0 then
                    SalesLine.Validate("Line Discount %", TempSalesLine."Line Discount %");

                if TempSalesLine."Location Code" <> '' then
                    SalesLine.Validate("Location Code", TempSalesLine."Location Code");

                SalesLine.Modify(true);
            until TempSalesLine.Next() = 0;

        // Update Temp Header status
        TempSalesHeader.Status := TempSalesHeader.Status::Processed;
        TempSalesHeader."Processed Document No." := SalesHeader."No.";
        TempSalesHeader."Processed Document Type" := DocumentType;
        TempSalesHeader."Error Message" := '';
        TempSalesHeader.Modify(true);

        Message('Successfully created %1 %2 from Temp Entry No. %3.',
            Format(DocumentType), SalesHeader."No.", TempSalesHeader."Entry No.");
    end;
}
