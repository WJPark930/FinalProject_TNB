function searchPage(pageNumber){
    document.querySelector('input[name="pageNumber"]').value = pageNumber;
    document.querySelector('form[name="searchForm"]').submit();
}


window.addEventListener('load', function() {  

    const price_range = document.querySelector('input[name="price_range"]');

    $('input[name="category_id"]').click(function(e) {
        document.querySelector('form[name="searchForm"]').submit();
        });

    $('input[name="service"]').click(function(e) {
        document.querySelector('form[name="searchForm"]').submit();
        });

    price_range.addEventListener("change", (e) => {
        document.querySelector('form[name="searchForm"]').submit();
    });

    
    
})

function selectItem(column){
    const whatColumn = document.querySelector('input[name="whatColumn"]');
    whatColumn.value = column;
    //console.log(whatColumn.value);
    document.querySelector('form[name="searchForm"]').submit();
}
