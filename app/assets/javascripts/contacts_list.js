$(document).ready(function() {
  bindDeleteHandlers();
});

function bindDeleteHandlers() {
  $('.delete-button').on('click', function(event) {
    event.preventDefault();
    var contact = $(this).parent();
    deleteContact(contact);
  })
}

function deleteContact(contact) {
  var contactId = contact.data().id;
  $.ajax({
    url: "/contacts/" + contactId,
    type: "DELETE",
    data: { id: contactId },
    complete: function() {
      contact.remove();
    }
  })
}
