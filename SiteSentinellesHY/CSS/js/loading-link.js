(function ($) {
    $.fn.loadingLink = function (texte) {
        this.click(function () {
            var falseButton = $(this).clone();
            falseButton.prop('disabled', true);

            falseButton.html(texte);
            falseButton.val(texte);
            falseButton.removeAttr('href');
            falseButton.removeAttr('id');
            $(this).hide();
            falseButton.insertAfter(this);
        });
    };
}(jQuery));