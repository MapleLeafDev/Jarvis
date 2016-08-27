jQuery(function ($) {
  var show_error, stripeResponseHandler;
  $("#new_registration").submit(function (event) {
    var $form;
    $form = $(this);
    $form.find("input[type=submit]").prop("disabled", true);
    Stripe.card.createToken($form, stripeResponseHandler);
    return false;
  });

  stripeResponseHandler = function (status, response) {
    var $form, token;
    $form = $("#new_registration");
    if (response.error) {
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"registration[card_token]\" />").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvv]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $form.get(0).submit();
    }
    return false;
  };

  show_error = function (message) {
    $(".errors").html('<div class="alert alert-danger"><ul><li>' + message + '</li></ul></div>');
    return false;
  };
});
