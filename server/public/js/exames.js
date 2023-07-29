function populateExams() {
  const fragment = new DocumentFragment()
  const createEl = (element) => document.createElement(element)
  const url = '/api/exams'

  fetch(url)
    .then(response => response.json())
    .then(({ success, data }) => {
      if (success) {
        data.forEach(({ token, date, patient_cpf }) => {
          const tr = createEl('tr')
          const tdToken = createEl('td')
          tdToken.textContent = token
          const tdDate = createEl('td')
          tdDate.textContent = date
          const tdPatient = createEl('td')
          tdPatient.textContent = patient_cpf
          const tdDetails = createEl('td')
          const linkDetails = createLink(token)
          tdDetails.appendChild(linkDetails)
          tr.append(tdToken, tdDate, tdPatient, tdDetails)
          fragment.appendChild(tr)
        });
      }
    })
    .then(() => {
      document.querySelector('tbody').appendChild(fragment)
    }).catch(console.log)

  function createLink(token) {
    const link = createEl('a')
    link.innerHTML = "Detalhes"
    link.href = `/exams/${token}`
    return link
  }
}

function buscarToken() {
  const token = document.getElementById('token').value.trim
  if (token.length >= 6) {
    window.location.href = `/exams/${token}`
  } else {
    alert('preencha com um token valido')
  }

}

function importCsv() {
  const input = document.querySelector('input[type="file"]')
  const formData = new FormData()

  formData.append('file', input.files[0])

  fetch('/api/exams/import', {
    method: 'POST',
    body: formData
  })
    .then(response => response.json())
    .then(result => {
      console.log('Success:', result);
    })
    .catch(error => {
      console.error('Error:', error);
    })
}

function getExamDetails() {
  const fragment = new DocumentFragment()
  const token = document.URL.split('/')[4]
  const url = `/api/exams/${token}`

  fetch(url)
    .then(response => response.json())
    .then(({ success, data }) => {
      const card = document.createElement('div')
      card.classList.add('card', 'text-white', 'bg-dark')
      const backLink = document.createElement('a')
      backLink.innerHTML = 'Voltar'
      backLink.href = '/exams'

      if (success) {
        const cardHeader = document.createElement('div')
        cardHeader.classList.add('card-header')
        const cardBody = document.createElement('div')
        cardBody.classList.add('card-body')

        const h2 = document.createElement('h2')
        h2.textContent = `Dados do exame: ${data.token}`
        const date = document.createElement('p')
        date.textContent = `Data do exame: ${data.date}`
        cardHeader.append(h2, date, backLink)

        const patient = document.createElement('div')
        const patientTitle = document.createElement('h3')
        patientTitle.textContent = 'Dados do Paciente'
        const patientName = document.createElement('p')
        patientName.textContent = `Nome: ${data.patient.name}`
        const patientEmail = document.createElement('p')
        patientEmail.textContent = `Email: ${data.patient.email}`
        const patientCpf = document.createElement('p')
        patientCpf.textContent = `CPF: ${data.patient.cpf}`
        const patientAddress = document.createElement('p')
        patientAddress.textContent = `Endereço: ${data.patient.address}`
        const patientCity = document.createElement('p')
        patientCity.textContent = `Cidade: ${data.patient.city}`
        const patientState = document.createElement('p')
        patientState.textContent = `Estado: ${data.patient.state}`
        patient.classList.add('border')
        patient.append(patientTitle, patientName, patientEmail, patientCpf, patientAddress, patientCity, patientState)

        const doctor = document.createElement('div')
        const doctorTitle = document.createElement('h3')
        doctorTitle.textContent = 'Dados do Medico'
        const doctorName = document.createElement('p')
        doctorName.textContent = `Nome: ${data.doctor.name}`
        const doctorEmail = document.createElement('p')
        doctorEmail.textContent = `Email: ${data.doctor.email}`
        const doctorCrm = document.createElement('p')
        doctorCrm.textContent = `CRM: ${data.doctor.crm}`
        const doctorCrmState = document.createElement('p')
        doctorCrmState.textContent = `CRM Estado: ${data.doctor.crm_state}`
        doctor.classList.add('border')
        doctor.append(doctorTitle, doctorName, doctorEmail, doctorCrm, doctorCrmState)

        const examItems = document.createElement('div')
        const examItemsTitle = document.createElement('h3')
        examItemsTitle.textContent = "Lista de exames"
        data.exam_items.forEach(({ type, limits_between, result, exam_token }) => {
          const exam_item = document.createElement('div')
          exam_item.classList.add('border', 'border-3', 'm-2', 'p-2')
          const type_p = document.createElement('p')
          type_p.textContent = `Tipo de exame: ${type}`
          const limits_between_p = document.createElement('p')
          limits_between_p.textContent = `Limites do exame: ${limits_between}`
          const result_p = document.createElement('p')
          result_p.textContent = `Resultado: ${result}`
          exam_item.append(type_p, limits_between_p, result_p)

          fragment.appendChild(exam_item)
        });
        examItems.append(examItemsTitle, fragment)

        cardBody.append(patient, doctor, examItems)
        card.append(cardHeader, cardBody)
      } else {
        const notFound = document.createElement('h3')
        notFound.textContent = `Exame não encontrado para o token: ${token}`
        card.classList.add('p-4')
        card.append(notFound, backLink)
      }
      document.querySelector('.container').appendChild(card)
    })
}


