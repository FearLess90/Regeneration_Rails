$(document).ready(function() {
    var nowTemp = new Date();
    now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    
    var dp = $('#dp3').datepicker({
      onRender: function(date) {
        return date.valueOf() < now.valueOf() ? 'disabled' : '';
      }
    });
    dp.datepicker('setValue', now);


	$("#ClientDetails").hide();
    $("#TasksDetails").hide();
    $("#tb_clients").typeahead({
        minLength: 1,
        source: function(query, process) {
        	objects = [];
    		map = {};
	        var $items = new Array;
    		$items = [""];
    		var data = JSON.parse(gon.clients);
    		$.map(data, function(data){
                var group;
                group = {
                    id: data.id,
                    name: data.name,                            
                    toString: function () {
                        return JSON.stringify(this);
                    },
                    toLowerCase: function () {
                        return this.name.toLowerCase();
                    },
                    indexOf: function (string) {
                        return String.prototype.indexOf.apply(this.name, arguments);
                    },
                    replace: function (string) {
                        var value = '';
                        value +=  this.name;
                        if(typeof(this.level) != 'undefined') {
                            value += ' <span class="pull-right muted">';
                            value += this.level;
                            value += '</span>';
                        }
                        return String.prototype.replace.apply('<div>' + value + '</div>', arguments);
                    }
                };
                $items.push(group);
            });

            process($items);
    		
        },
        matcher: function (item) {
		    if (item.toLowerCase().substring(0, this.query.trim().length) == this.query.toLowerCase().trim()) {
		        return true;
		    }
		},
		updater: function (item) {
		    $.ajax({
		            type: "POST",
		            url: "/clients/get_client.js?id=" + JSON.parse(item).id
	        });
		}
    });

    $('#myTab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

    $(".itemList").on('dblclick', function(){
        cartridge = $('#cart [data-item="' + $(this).data("item") + '"]');     
        if (!cartridge.next().is('span')){
            cartridge = $( "<div data-item=" + $(this).data("item")+ "></div>" ).text($(this).text()).addClass("itemList").appendTo($("#cart fieldset"));
            cartridge.wrap('<div class="cartridge-item" />');
            cartridge.addClass("inline_class");
            cartridge.after($('<input class="spinner" name="value" />'));
            quantity = cartridge.next().spinner();
            quantity.spinner('value', 1);
        }
        else {
            quantity = $(cartridge.next().children()[0]).spinner();
            quantity.spinner('value', quantity.spinner('value') + 1 );
        }
    });

    $(function() {
        $(".itemList").draggable({
            appendTo: ".modal-body",
            helper: 'clone'
        });
        $("#cart").droppable({
            accept: ".itemList",
            drop: function(event, ui) {
                test = ui.draggable;
                cartridge = $('#cart [data-item=' + ui.draggable.data("item") + ']'); 
                if (!cartridge.next().is('span')){
                    cartridge = $( "<div data-item=" + ui.draggable.data("item")+ "></div>" ).text(ui.draggable.text()).addClass("itemList").appendTo($("#cart fieldset"));
                    cartridge.wrap('<div class="cartridge-item" />');
                    cartridge.addClass("inline_class");
                    cartridge.after($('<input class="spinner" name="value" />'));
                    quantity = cartridge.next().spinner();
                    quantity.spinner('value', 1);
                }
                else {
                    quantity = $(cartridge.next().children()[0]).spinner();
                    quantity.spinner('value', quantity.spinner('value') + 1 );
                }
            }
        });
    });

    $(document).on('click','#submit-task', function(){
        tasks = [];
        $("#cart .cartridge-item").each(function( index ) {
            var cartridge_quantity = $(this).find('.spinner').val();
            for (var i=0; i<cartridge_quantity; i++) {
                var task = new Object();
                task.cartridgeId = $(this).data("item");
                task.completitionDate = $("#dp3 input").val();
                task.clientId = $("dl dd").first().text();
                task.checkinDate = now; 
                tasks.push(task);
                console.log(tasks);
            }
        });
        var jsonstring = "{\"tasksjson\":"+JSON.stringify(tasks) + "}";
        $.ajax({
            type : "POST",
            url :  '/tasks/create.js',
            contentType: 'application/json',
            data : jsonstring
          });
    });
});