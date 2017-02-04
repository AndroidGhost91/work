function loadTooltips() {
  $('[data-toggle="tooltip"]').tooltip()
}

$(document).ready(loadTooltips);
$(document).on('page:load', loadTooltips);
