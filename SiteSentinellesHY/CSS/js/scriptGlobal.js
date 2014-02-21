$(document).ready(function(){
	$('button.disable-button').click(function () {
		var falseButton = $(this).clone();
		falseButton.prop('disabled', true);
		falseButton.html('Chargement...');
		$(this).hide();
		falseButton.insertAfter($(this));
	});

	$('a.disabled-button').click(function () {
		var falseButton = $(this).clone();
		falseButton.prop('disabled', true);
		falseButton.html('Chargement...');
		falseButton.removeAttr('href');
		$(this).hide();
		falseButton.insertAfter($(this));
	});

	$('input[type="submit"].disable-button').click(function () {
		var falseButton = $(this).clone();
		falseButton.prop('disabled', true);
		falseButton.val('Chargement...');
		$(this).hide();
		falseButton.insertAfter($(this));
	});

	$('[data-toggle="tooltip"]').tooltip();
});