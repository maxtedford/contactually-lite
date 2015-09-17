$(document).ready(function() {
  bindDeleteHandlers();
  bindInternationalFilterHandler();
  bindExtensionFilterHandler();
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

function bindInternationalFilterHandler() {
  $('#international-filter-button').on('click', function(event) {
    event.preventDefault();
    filterInternationalContacts();
  })
}

function filterInternationalContacts() {
  var $contacts = $('.contact');
  var $domesticContacts = $contacts.filter(function(_index, _contact) {
    return $(this).data().international;
  });
  $domesticContacts.each(function(_index, _contact) {
    $(this).toggle();
  });
}

function bindExtensionFilterHandler() {
  $('#extension-filter-button').on('click', function(event) {
    event.preventDefault();
    filterExtensions();
  })
}

function filterExtensions() {
  var $contacts = $('.contact');
  var $domesticContacts = $contacts.filter(function(_index, _contact) {
    return $(this).data().extension === "";
  });
  $domesticContacts.each(function(_index, _contact) {
    $(this).toggle();
  });
}
