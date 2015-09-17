$(document).ready(function() {
  bindDeleteHandlers();
  bindInternationalFilterHandler();
  bindExtensionFilterHandler();
  bindDotComEmailFilterHandler();
  bindEmailSortHandler();
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
  var $nonExtensions = $contacts.filter(function(_index, _contact) {
    return $(this).data().extension === "";
  });
  $nonExtensions.each(function(_index, _contact) {
    $(this).toggle();
  });
}

function bindDotComEmailFilterHandler() {
  $('#dot-com-filter-button').on('click', function(event) {
    event.preventDefault();
    filterDotComEmails();
  })
}

function filterDotComEmails() {
  var $contacts = $('.contact');
  var $nonDotComs = $contacts.filter(function(_index, _contact) {
    return !$(this).data().email.includes('.com');
  });
  $nonDotComs.each(function(_index, _contact) {
    $(this).toggle();
  });
}

function bindEmailSortHandler() {
  $('#sort-by-email-address').on('click', function(event) {
    event.preventDefault();
    sortByEmail();
  })
}

function sortByEmail() {
  var arr = [];
  
  $('.contact').each(function() {
    var email = $(this).data().email;
    arr.push([email, $(this)]);
    $(this).remove()
  });
  
  var sorted = arr.sort();
  
  sorted.forEach(function(element) {
    $('#contacts').append(element[1]);
  })
}
