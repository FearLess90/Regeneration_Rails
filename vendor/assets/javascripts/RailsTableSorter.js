/**
 * Created By Pasquale Lupia
 * Date: 5/2/13
 * Time: 3:20 PM
 */

(function( $ ) {
    $.fn.railsTableSorter = function(options) {
        var settings = $.extend( {
            'controller': "",
            'action': "" ,
            'table_id': ""
        }, options);
        var class_name = $(this).attr("class");
        var current = $(this).index();
        var page = $(".active").text();
        var id = $("dd").first().text();
        $("#" + options.table_id + " th").each(function(index){
            if (index != current) {
                $(this).removeClass();
                if (index != $("#" + options.table_id + " th").length -1 ) {
                    $(this).addClass("header");
                }
            }
        });
        var url;
        if (class_name == "header"){

            url = "/" + options.controller + "/" + options.action + ".js?column=" + $(this).text().replace(/ /g, '_').toLowerCase() + "&direction=asc&page=" + page;
            url += id != "" ? "&id=" + id : "";
            $(this).removeClass("header")
            $(this).addClass("headerSortDown");
        }
        else if (class_name == "headerSortDown") {
            url = "/" + options.controller + "/" + options.action + ".js?column=" + $(this).text().replace(/ /g, '_').toLowerCase() + "&direction=desc&page=" + page;
            url += id != "" ? "&id=" + id : "";
            $(this).removeClass("headerSortDown")
            $(this).addClass("headerSortUp");
        }
        else {
            url = "/" + options.controller + "/" + options.action + ".js?column=created_at&direction=asc&page=" + page;
            url += id != "" ? "&id=" + id : "";
            $(this).removeClass("headerSortUp");
            $(this).addClass("header");
        }
        $.ajax({
            type: "POST",
            url: url
        })
    };
})( jQuery );