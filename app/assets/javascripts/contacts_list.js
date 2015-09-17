$(document).ready(function() {
  var $contacts = $('.contact');
  bindDeleteHandlers();
  bindInternationalFilterHandler($contacts);
  bindExtensionFilterHandler($contacts);
  bindDotComEmailFilterHandler($contacts);
  bindEmailSortHandler();
});

function bindDeleteHandlers() {
  $('.delete-button').on('click', function(event) {
    event.preventDefault();
    var contact = $(this).parent();
    deleteContact(contact);
  })
}

function bindInternationalFilterHandler($contacts) {
  $('#international-filter-button').on('click', function(event) {
    event.preventDefault();
    filterInternationalContacts($contacts);
  })
}

function bindExtensionFilterHandler($contacts) {
  $('#extension-filter-button').on('click', function(event) {
    event.preventDefault();
    filterExtensions($contacts);
  })
}

function bindDotComEmailFilterHandler($contacts) {
  $('#dot-com-filter-button').on('click', function(event) {
    event.preventDefault();
    filterDotComEmails($contacts);
  })
}

function bindEmailSortHandler() {
  $('#sort-by-email-address').on('click', function(event) {
    event.preventDefault();
    sortByEmail();
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

function filterInternationalContacts($contacts) {
  var $domesticContacts = $contacts.filter(function(_index, contact) {
    return !$(contact).data().international;
  });
  $domesticContacts.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function filterExtensions($contacts) {
  var $nonExtensions = $contacts.filter(function(_index, contact) {
    return $(contact).data().extension === "";
  });
  $nonExtensions.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function filterDotComEmails($contacts) {
  var $nonDotComs = $contacts.filter(function(_index, contact) {
    return !$(contact).data().email.includes('.com');
  });
  $nonDotComs.each(function(_index, contact) {
    $(contact).toggle();
  });
}

function sortByEmail() {
  var arr = [];
  
  $('.contact').each(function() {
    var email = $(this).data().email;
    arr.push([email, $(this)]);
    $(this).remove()
  });
  
  var sortedContacts = arr.sort();
  
  sortedContacts.forEach(function(element) {
    $('#contacts').append(element[1]);
  })
}
