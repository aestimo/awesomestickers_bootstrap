/**
 * Created by aestimo on 6/21/14.
 */

$("[rel='tooltip']").tooltip();

$('#hover-cap-4col .thumbnail').hover(
    function(){
        $(this).find('.caption').slideDown(250); //.fadeIn(250)
    },
    function(){
        $(this).find('.caption').slideUp(250); //.fadeOut(205)
    }
);

});
