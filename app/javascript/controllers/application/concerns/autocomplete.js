import autoComplete from "@tarekraafat/autocomplete.js";

export function initCityAutocomplete({
  input,
  hiddenInput,
  data,
  onSelect = () => {}
}) {
  if (!input) return;

  new autoComplete({
    selector: () => input,
    threshold: 1,

    data: {
      src: data,
    },

    searchEngine: (query, record) => {
      return record.title?.toLowerCase().includes(query.toLowerCase());
    },

    resultsList: {
      maxResults: 20,
      noResults: true,
    },

    resultItem: {
      highlight: true,
      element: (item, data) => {
        item.innerHTML = data.value.title;
      },
    },

    events: {
      input: {
        selection: (event) => {
          const selected = event.detail.selection.value;

          input.value = selected.title;
          if (hiddenInput) hiddenInput.value = selected.id;

          onSelect(selected);
        },
      },
    },
  });
}
