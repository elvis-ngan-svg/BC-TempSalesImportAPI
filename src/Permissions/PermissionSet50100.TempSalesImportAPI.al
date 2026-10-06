permissionset 50100 "Temp Sales Import API"
{
    Assignable = true;
    Caption = 'Temp Sales Import API';
    Permissions =
        tabledata "Temp Sales Header" = RIMD,
        tabledata "Temp Sales Line" = RIMD,
        table "Temp Sales Header" = X,
        table "Temp Sales Line" = X,
        page "Temp Sales Header API" = X,
        page "Temp Sales Line API" = X,
        page "Temp Sales Order List" = X,
        page "Temp Sales Order Card" = X, 
        page "Temp Sales Lines Subpage" = X,
        codeunit "Temp Sales Order Mgt" = X;
}
