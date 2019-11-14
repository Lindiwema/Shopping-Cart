<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroceryForm.aspx.cs" Inherits="Grocery.GroceryForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css"/>

    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.min.css" />
    <script src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />


    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>




    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <style>
        * {
            box-sizing: border-box;
        }

        .column {
            float: left;
            padding: 10px;
            height: 100%;
        }

        .left, .right {
            width: 20%;
        }

        .middle {
            width: 60%;
        }

        .row:after {
            content: "";
            display: table;
            clear: both;
        }







        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
        }

        .topnav-right {
            float: right;
        }

        .topnav {
            overflow: hidden;
            background-color: #e9e9e9;
        }

            .topnav a {
                float: left;
                display: block;
                color: black;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
                font-size: 17px;
            }

                .topnav a:hover {
                    background-color: #ddd;
                    color: black;
                }

                .topnav a.active {
                    background-color: #2196F3;
                    color: white;
                }

            .topnav .search-container {
                float: right;
            }

            .topnav input[type=text] {
                padding: 6px;
                margin-top: 8px;
                font-size: 17px;
                border: none;
            }

            .topnav .search-container button {
                float: right;
                padding: 6px 10px;
                margin-top: 8px;
                margin-right: 16px;
                background: #ddd;
                font-size: 17px;
                border: none;
                cursor: pointer;
            }

                .topnav .search-container button:hover {
                    background: #ccc;
                }

        @media screen and (max-width: 600px) {
            .topnav .search-container {
                float: none;
            }

                .topnav a, .topnav input[type=text], .topnav .search-container button {
                    float: none;
                    display: block;
                    text-align: left;
                    width: 100%;
                    margin: 0;
                    padding: 14px;
                }

            .topnav input[type=text] {
                border: 1px solid #ccc;
            }
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: 'GroceryService.asmx/GetGrocery_',
                method: 'post',
                dataType: 'json',
                success: function (data) {

                    var table = $('#datatable').dataTable({

                        paging: true,
                        sort: true,
                        searching: true,
                        scrollY: 200,
                        data: data,
                        deferRender: true,
                        //idDisplayLength: 10,
                        select: true,
                        colspan: 7,
                        rowId: "ID",
                        columns: [


                            {
                                'data': 'ProductImageUrl',
                                'sortable': false,
                                'searchable': false,
                                'select': true,
                                'colspan': 7,
                                'rowId': "ID",
                                'render': function (ImageUrl) {
                                    if (!ImageUrl) {
                                        return 'N/A';
                                    }
                                    else {
                                        return '<img class="img-responsive thumbnail" src=' + ImageUrl + '>'
                                        '/>';
                                    }
                                },

                            },

                            { 'data': 'ID' },
                            { 'data': 'ProductName' },
                            { 'data': 'ProductDescription' }


                            
                        ],
                        'columnDefs': [
                            {
                            'targets': 4,
                            'sortable': false,
                            'searchable': false,
                            "Data": null,


                            'defaultContent': '<button class="btn btn-info btn-sm"  onclick="clickCounter()" type="button">' + "Add To Cart" + '</button>' +
                                    '<input type="number" class="form-control text-center" value="1" />'
                            },

                        ]

                    });

                }

            });

            //here i wanted to make each row to have an id, however it is not doing so

            $('#datatable tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                } else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            $('#edit').click(function () {
                var selectedRow = table.row('selected').ID();
                console.log(selectedRow);
                alert(selectedRow);
            });
        });

        //button

        function clickCounter() {
            if (typeof (Storage) !== "undefined") {

                $.ajax({
                    url: 'GroceryService.asmx/GetGrocery_',
                    method: 'post',
                    dataType: 'json',
                    success: function (data) {



                        if (localStorage.clickcount) {
                            localStorage.clickcount = Number(localStorage.clickcount) + 1;


                            localStorage.setItem('GetGrocery_', JSON.stringify(data));

                            sessionStorage.MyBasket = localStorage.clickcount;

                        } else {
                            localStorage.clickcount = 1;
                        }
                        document.getElementById("result").innerHTML = localStorage.clickcount;

                    }
                });






            } else {
                document.getElementById("result").innerHTML = "Sorry, your browser does not support web storage...";
            }

        }
        function myFunction() {
            var x = sessionStorage["MyBasket"];
            document.getElementById("BasketResults").innerHTML = x;
        }
        function DeleteOrder()
        {
            localStorage.clear();
            console.log(localStorage);
            document.getElementById("BasketResults").innerHTML = x;
        }

    </script>
</head>
<body>



    <%-- localStorage.clear();--%>
    <div class="row">
        <div class="topnav">
            <div class="topnav-right">
                <a href="#User">hello User!</a>
                <a href="#Busket" onclick="myFunction()" data-toggle="modal" data-target="#myModal">Busket <span class="glyphicon glyphicon-shopping-cart"><span id="result"></span></span></a>

            </div>
        </div>
        <div class="column left">
            <button id="edit">Edit</button>
        </div>
        <div class="column middle">
            <asp:Panel ID="Panel1" runat="server">
                <table id="datatable" class="table table-hover table-condensed" style=" height:100%">
                    <thead>
                        <tr>
                            
                            
                            <th>Product</th>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Product Description</th>
                            <th></th>
                        </tr>
                    </thead>


                </table>

            </asp:Panel>

        </div>
        <div class="column right">
        </div>
    </div>





    <div class="container">

        <!-- The Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Oder List</h4>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <p id="BasketResults"></p>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-dismiss="modal">Submit Order</button>
                        <button onclick="DeleteOrder()" type="button" class="btn btn-danger" data-dismiss="modal">Cancel Order</button>
                    </div>

                </div>
            </div>
        </div>

    </div>




</body>
</html>
