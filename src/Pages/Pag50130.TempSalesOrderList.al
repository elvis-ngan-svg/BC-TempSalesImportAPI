page 50130 "Temp Sales Order List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Temp Sales Header";
    Caption = 'Temp Sales Orders';
    CardPageId = "Temp Sales Order Card";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        { 
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Processed Document No."; Rec."Processed Document No.")
                {
                    ApplicationArea = All;
                }
                field("Processed Document Type"; Rec."Processed Document Type")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created DateTime"; Rec."Created DateTime")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                Image = Process;

                action(MarkAsReady)
                {
                    ApplicationArea = All;
                    Caption = 'Mark as Ready';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Mark the selected records as Ready so they can be converted to Sales Order / Quote.';

                    trigger OnAction()
                    var
                        TempSalesHeader: Record "Temp Sales Header";
                    begin
                        CurrPage.SetSelectionFilter(TempSalesHeader);
                        if TempSalesHeader.FindSet() then
                            repeat
                                if TempSalesHeader.Status = TempSalesHeader.Status::New then begin
                                    TempSalesHeader.Status := TempSalesHeader.Status::Ready;
                                    TempSalesHeader.Modify(true);
                                end;
                            until TempSalesHeader.Next() = 0;
                        CurrPage.Update(false);
                    end;
                }

                action(CreateSalesOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Create Sales Order';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Convert the selected Temp Sales Header into a real Sales Order.';
                    Enabled = Rec.Status = Rec.Status::Ready;

                    trigger OnAction()
                    var
                        TempSalesMgt: Codeunit "Temp Sales Order Mgt";
                    begin
                        TempSalesMgt.CreateSalesDocument(Rec, "Sales Document Type"::Order);
                        CurrPage.Update(false);
                    end;
                }

                action(CreateSalesQuote)
                {
                    ApplicationArea = All;
                    Caption = 'Create Sales Quote';
                    Image = Quote;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Convert the selected Temp Sales Header into a real Sales Quotation.';
                    Enabled = Rec.Status = Rec.Status::Ready;

                    trigger OnAction()
                    var
                        TempSalesMgt: Codeunit "Temp Sales Order Mgt";
                    begin
                        TempSalesMgt.CreateSalesDocument(Rec, "Sales Document Type"::Quote);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    var
        StatusStyle: Text;

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::New:
                StatusStyle := 'Standard';
            Rec.Status::Ready:
                StatusStyle := 'Favorable';
            Rec.Status::Processed:
                StatusStyle := 'Subordinate';
            Rec.Status::Error:
                StatusStyle := 'Unfavorable';
        end;
    end;
}
