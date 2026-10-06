page 50131 "Temp Sales Order Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = "Temp Sales Header";
    Caption = 'Temp Sales Order';
    Editable = true;

    layout
    {
        area(Content)
        { 
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
            }
            group(Processed)
            {
                Caption = 'Processed Information';
                Visible = Rec.Status = Rec.Status::Processed;

                field("Processed Document No."; Rec."Processed Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Processed Document Type"; Rec."Processed Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Temp Sales Lines Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkAsReady)
            {
                ApplicationArea = All;
                Caption = 'Mark as Ready';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Ready;
                    Rec.Modify(true);
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
