
<div class="container">
    <h2>Payment Form</h2>
    <form action="paymentForm" method="post">
        <div class="form-group">
            <label for="patientId">Patient ID:</label>
            <input type="number" id="patientId" name="patientId" required class="form-control">
        </div>

        <div class="form-group">
            <label for="serviceName">Service Name:</label>
            <input type="text" id="serviceName" name="serviceName" required class="form-control">
        </div>

        <div class="form-group">
            <label for="amount">Amount:</label>
            <input type="number" step="0.01" id="amount" name="amount" required class="form-control">
        </div>

        <div class="form-group">
            <label for="paymentDate">Payment Date:</label>
            <input type="date" id="paymentDate" name="paymentDate" required class="form-control">
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status" required class="form-control">
                <option value="Pending">Pending</option>
                <option value="Completed">Completed</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Submit Payment</button>
    </form>
</div>
