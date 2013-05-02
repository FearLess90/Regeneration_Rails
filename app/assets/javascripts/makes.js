$(document).ready(function() {
    $("th").click(function() {
        $(this).railsTableSorter({
            controller : 'makes',
            action: 'sort'
        });
    });
});

