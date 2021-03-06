import React, {useEffect, useState} from 'react'

export default function App() {
    const [message, setMessage] = useState('')

    useEffect(() => {
        fetch(process.env.REACT_APP_SERVER_URL + '/api/greeting')
            .then(res => res.json())
            .then(messages => setMessage(messages[0]))
    })

    return (
        <div>
            <header>
                <p>{message}</p>
            </header>
        </div>
    )
}
