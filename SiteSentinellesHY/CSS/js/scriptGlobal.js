$(document).ready(function(){
	$('button.disable-button, a.disabled-button').click(function(){
		$(this).prop('disabled', true);
		$(this).html('Chargement...');
	});
	$('input[type="submit"].disable-button').click(function(){
		$(this).prop('disabled', true);
		$(this).val('Chargement...');
	});
});